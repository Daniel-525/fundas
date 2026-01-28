package util;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import com.itextpdf.text.pdf.draw.LineSeparator;
import jakarta.servlet.http.HttpServletResponse;
import model.Factura;
import model.DetalleFactura;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class PdfGenerator {

    public static void generar(HttpServletResponse response, Factura factura) {

        try {
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=factura_" +
                    factura.getCliente().replaceAll("\\s+", "_") + ".pdf");

            Document doc = new Document(PageSize.A4, 40, 40, 50, 40);
            PdfWriter.getInstance(doc, response.getOutputStream());
            doc.open();

            // ===== FECHA AUTOMÁTICA =====
            LocalDate fechaActual = LocalDate.now();
            DateTimeFormatter formato = DateTimeFormatter.ofPattern("dd/MM/yyyy");

            // Número de factura aleatorio (en producción usar una secuencia real)
            String numeroFactura = String.format("%08d", (int)(Math.random() * 99999999));

            // ===== FUENTES MEJORADAS =====
            Font tituloEmpresa = new Font(Font.FontFamily.HELVETICA, 24, Font.BOLD, new BaseColor(102, 126, 234));
            Font subtituloDoc = new Font(Font.FontFamily.HELVETICA, 16, Font.BOLD, new BaseColor(118, 75, 162));
            Font infoHeader = new Font(Font.FontFamily.HELVETICA, 10, Font.NORMAL, BaseColor.DARK_GRAY);
            Font labelCampo = new Font(Font.FontFamily.HELVETICA, 9, Font.BOLD, BaseColor.DARK_GRAY);
            Font valorCampo = new Font(Font.FontFamily.HELVETICA, 11, Font.NORMAL, BaseColor.BLACK);
            Font encabezadoTabla = new Font(Font.FontFamily.HELVETICA, 10, Font.BOLD, BaseColor.WHITE);
            Font contenidoTabla = new Font(Font.FontFamily.HELVETICA, 10, Font.NORMAL);
            Font totalLabel = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD, BaseColor.DARK_GRAY);
            Font totalValor = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD, new BaseColor(17, 153, 142));
            Font pieDocumento = new Font(Font.FontFamily.HELVETICA, 9, Font.ITALIC, BaseColor.GRAY);

            // ===== ENCABEZADO EMPRESA =====
            Paragraph nombreEmpresa = new Paragraph("VIVI FUNDAS", tituloEmpresa);
            nombreEmpresa.setAlignment(Element.ALIGN_CENTER);
            nombreEmpresa.setSpacingAfter(5);
            doc.add(nombreEmpresa);

            Paragraph slogan = new Paragraph("Los mejores en lo que hacemos", infoHeader);
            slogan.setAlignment(Element.ALIGN_CENTER);
            slogan.setSpacingAfter(3);
            doc.add(slogan);


            // ===== LÍNEA SEPARADORA DECORATIVA =====
            LineSeparator lineaGruesa = new LineSeparator();
            lineaGruesa.setLineColor(new BaseColor(102, 126, 234));
            lineaGruesa.setLineWidth(2f);
            doc.add(new Chunk(lineaGruesa));
            doc.add(new Paragraph("\n"));

            // ===== TÍTULO DEL DOCUMENTO =====
            Paragraph tipoDoc = new Paragraph("FACTURA DE VENTA", subtituloDoc);
            tipoDoc.setAlignment(Element.ALIGN_CENTER);
            tipoDoc.setSpacingAfter(20);
            doc.add(tipoDoc);

            // ===== TABLA DE INFORMACIÓN (Factura # y Fecha) =====
            PdfPTable tablaInfo = new PdfPTable(2);
            tablaInfo.setWidthPercentage(100);
            tablaInfo.setWidths(new float[]{1, 1});
            tablaInfo.setSpacingAfter(15);

            // Celda Número de Factura
            PdfPCell celdaNumFactura = new PdfPCell();
            celdaNumFactura.setBorder(Rectangle.BOX);
            celdaNumFactura.setBorderColor(new BaseColor(200, 200, 200));
            celdaNumFactura.setPadding(10);
            celdaNumFactura.setBackgroundColor(new BaseColor(248, 249, 250));


            // Celda Fecha
            PdfPCell celdaFecha = new PdfPCell();
            celdaFecha.setBorder(Rectangle.BOX);
            celdaFecha.setBorderColor(new BaseColor(200, 200, 200));
            celdaFecha.setPadding(10);
            celdaFecha.setBackgroundColor(new BaseColor(248, 249, 250));

            Paragraph fechaLabel = new Paragraph("Fecha de Emisión", labelCampo);
            Paragraph fechaValor = new Paragraph(fechaActual.format(formato), valorCampo);
            celdaFecha.addElement(fechaLabel);
            celdaFecha.addElement(fechaValor);
            tablaInfo.addCell(celdaFecha);

            doc.add(tablaInfo);

            // ===== INFORMACIÓN DEL CLIENTE =====
            PdfPTable tablaCliente = new PdfPTable(1);
            tablaCliente.setWidthPercentage(100);
            tablaCliente.setSpacingAfter(20);

            PdfPCell celdaCliente = new PdfPCell();
            celdaCliente.setBorder(Rectangle.BOX);
            celdaCliente.setBorderColor(new BaseColor(102, 126, 234));
            celdaCliente.setBorderWidth(1.5f);
            celdaCliente.setPadding(12);
            celdaCliente.setBackgroundColor(new BaseColor(247, 248, 252));

            Paragraph clienteLabel = new Paragraph("TRABAJADOR", labelCampo);
            clienteLabel.setSpacingAfter(5);
            Paragraph clienteNombre = new Paragraph(factura.getCliente(), new Font(Font.FontFamily.HELVETICA, 13, Font.BOLD, BaseColor.BLACK));

            celdaCliente.addElement(clienteLabel);
            celdaCliente.addElement(clienteNombre);
            tablaCliente.addCell(celdaCliente);

            doc.add(tablaCliente);

            // ===== TÍTULO DETALLE =====
            Paragraph detalleTitle = new Paragraph("DETALLE DE PRODUCTOS",
                    new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD, new BaseColor(118, 75, 162)));
            detalleTitle.setSpacingAfter(10);
            doc.add(detalleTitle);

            // ===== TABLA DE PRODUCTOS MEJORADA =====
            PdfPTable tablaProductos = new PdfPTable(5);
            tablaProductos.setWidthPercentage(100);
            tablaProductos.setWidths(new float[]{0.5f, 3f, 1.5f, 1f, 1.5f});
            tablaProductos.setSpacingAfter(15);

            // Encabezados con diseño moderno
            BaseColor colorEncabezado = new BaseColor(102, 126, 234);
            agregarCeldaEncabezadoModerna(tablaProductos, "#", encabezadoTabla, colorEncabezado);
            agregarCeldaEncabezadoModerna(tablaProductos, "PRODUCTO", encabezadoTabla, colorEncabezado);
            agregarCeldaEncabezadoModerna(tablaProductos, "PRECIO UNIT.", encabezadoTabla, colorEncabezado);
            agregarCeldaEncabezadoModerna(tablaProductos, "CANT.", encabezadoTabla, colorEncabezado);
            agregarCeldaEncabezadoModerna(tablaProductos, "SUBTOTAL", encabezadoTabla, colorEncabezado);

            // Datos de productos con alternancia de colores
            int contador = 1;
            for (DetalleFactura d : factura.getDetalles()) {
                BaseColor colorFila = (contador % 2 == 0) ?
                        new BaseColor(248, 249, 250) : BaseColor.WHITE;

                agregarCeldaContenido(tablaProductos, String.valueOf(contador),
                        contenidoTabla, Element.ALIGN_CENTER, colorFila);
                agregarCeldaContenido(tablaProductos, d.getProducto(),
                        contenidoTabla, Element.ALIGN_LEFT, colorFila);
                agregarCeldaContenido(tablaProductos, String.format("$%.2f", d.getPrecio()),
                        contenidoTabla, Element.ALIGN_RIGHT, colorFila);
                agregarCeldaContenido(tablaProductos, String.valueOf(d.getCantidad()),
                        contenidoTabla, Element.ALIGN_CENTER, colorFila);
                agregarCeldaContenido(tablaProductos, String.format("$%.2f", d.getSubtotal()),
                        new Font(Font.FontFamily.HELVETICA, 10, Font.BOLD), Element.ALIGN_RIGHT, colorFila);

                contador++;
            }

            doc.add(tablaProductos);

            // ===== SECCIÓN DE TOTAL =====
            PdfPTable tablaTotal = new PdfPTable(2);
            tablaTotal.setWidthPercentage(100);
            tablaTotal.setWidths(new float[]{3, 1});
            tablaTotal.setSpacingBefore(10);

            // Celda vacía
            PdfPCell celdaVacia = new PdfPCell();
            celdaVacia.setBorder(Rectangle.NO_BORDER);
            tablaTotal.addCell(celdaVacia);

            // Celda del total
            PdfPCell celdaTotal = new PdfPCell();
            celdaTotal.setBorder(Rectangle.BOX);
            celdaTotal.setBorderColor(new BaseColor(17, 153, 142));
            celdaTotal.setBorderWidth(2f);
            celdaTotal.setPadding(15);
            celdaTotal.setBackgroundColor(new BaseColor(240, 253, 250));

            Paragraph labelTotal = new Paragraph("TOTAL A PAGAR", totalLabel);
            labelTotal.setAlignment(Element.ALIGN_RIGHT);
            labelTotal.setSpacingAfter(5);

            Paragraph valorTotal = new Paragraph(String.format("$%.2f", factura.getTotal()), totalValor);
            valorTotal.setAlignment(Element.ALIGN_RIGHT);

            celdaTotal.addElement(labelTotal);
            celdaTotal.addElement(valorTotal);
            tablaTotal.addCell(celdaTotal);

            doc.add(tablaTotal);

            // ===== ESPACIO =====
            doc.add(new Paragraph("\n\n"));

            // ===== LÍNEA SEPARADORA FINAL =====
            LineSeparator lineaFinal = new LineSeparator();
            lineaFinal.setLineColor(new BaseColor(200, 200, 200));
            lineaFinal.setLineWidth(1f);
            doc.add(new Chunk(lineaFinal));
            doc.add(new Paragraph("\n"));

            // ===== PIE DE PÁGINA =====
            Paragraph agradecimiento = new Paragraph("¡Gracias por su ayuda!",
                    new Font(Font.FontFamily.HELVETICA, 11, Font.BOLD, new BaseColor(102, 126, 234)));
            agradecimiento.setAlignment(Element.ALIGN_CENTER);
            agradecimiento.setSpacingAfter(5);
            doc.add(agradecimiento);

            Paragraph notaPie = new Paragraph(
                    "GRACIAS.\n" +
                            "A TODOS",
                    pieDocumento);
            notaPie.setAlignment(Element.ALIGN_CENTER);
            doc.add(notaPie);

            doc.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ===== CELDA ENCABEZADO MODERNA =====
    private static void agregarCeldaEncabezadoModerna(PdfPTable tabla, String texto,
                                                      Font fuente, BaseColor colorFondo) {
        PdfPCell celda = new PdfPCell(new Phrase(texto, fuente));
        celda.setBackgroundColor(colorFondo);
        celda.setPadding(12);
        celda.setHorizontalAlignment(Element.ALIGN_CENTER);
        celda.setVerticalAlignment(Element.ALIGN_MIDDLE);
        celda.setBorderWidth(0);
        tabla.addCell(celda);
    }

    // ===== CELDA CONTENIDO CON ESTILO =====
    private static void agregarCeldaContenido(PdfPTable tabla, String texto,
                                              Font fuente, int alineacion, BaseColor colorFondo) {
        PdfPCell celda = new PdfPCell(new Phrase(texto, fuente));
        celda.setBackgroundColor(colorFondo);
        celda.setPadding(10);
        celda.setHorizontalAlignment(alineacion);
        celda.setVerticalAlignment(Element.ALIGN_MIDDLE);
        celda.setBorderColor(new BaseColor(230, 230, 230));
        celda.setBorderWidth(0.5f);
        tabla.addCell(celda);
    }
}
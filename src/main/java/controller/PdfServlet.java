package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.DetalleFactura;
import model.Factura;
import util.PdfGenerator;

import java.io.IOException;

@WebServlet("/pdf")
public class PdfServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        Factura factura = new Factura(request.getParameter("cliente"));

        String[] productos = request.getParameterValues("producto");
        String[] precios = request.getParameterValues("precio");
        String[] cantidades = request.getParameterValues("cantidad");

        for (int i = 0; i < productos.length; i++) {
            factura.agregarDetalle(
                    new DetalleFactura(
                            productos[i],
                            Double.parseDouble(precios[i]),
                            Integer.parseInt(cantidades[i])
                    )
            );
        }

        PdfGenerator.generar(response, factura);
    }
}

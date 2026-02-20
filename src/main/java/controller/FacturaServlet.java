package controller;

import model.DetalleFactura;
import model.Factura;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet("/factura")
public class FacturaServlet extends HttpServlet {

    // Cuando alguien entra por URL directa (GET)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Redirige al formulario principal
        response.sendRedirect("index.jsp");
    }

    // Cuando el formulario envía los datos (POST)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            String cliente = request.getParameter("cliente");

            String[] productos = request.getParameterValues("producto");
            String[] precios = request.getParameterValues("precio");
            String[] cantidades = request.getParameterValues("cantidad");

            if (productos == null || productos.length == 0) {
                response.sendRedirect("index.jsp");
                return;
            }

            Factura factura = new Factura(cliente);

            for (int i = 0; i < productos.length; i++) {

                DetalleFactura detalle = new DetalleFactura(
                        productos[i],
                        Double.parseDouble(precios[i]),
                        Integer.parseInt(cantidades[i])
                );

                factura.agregarDetalle(detalle);
            }

            request.setAttribute("factura", factura);
            request.getRequestDispatcher("previsualizacion.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp");
        }
    }
}
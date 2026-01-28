<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Factura, model.DetalleFactura" %>
<%
    Factura factura = (Factura) request.getAttribute("factura");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Previsualización de Factura</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            overflow: hidden;
            animation: fadeIn 0.5s ease;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px;
            text-align: center;
        }

        .header h2 {
            font-size: 2.5em;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
        }

        .header p {
            font-size: 1.1em;
            opacity: 0.95;
        }

        .factura-body {
            padding: 40px;
        }

        .info-cliente {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            padding: 25px;
            border-radius: 12px;
            margin-bottom: 30px;
            border-left: 5px solid #667eea;
        }

        .info-cliente label {
            display: block;
            color: #666;
            font-size: 0.9em;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 5px;
            font-weight: 600;
        }

        .info-cliente .cliente-nombre {
            font-size: 1.8em;
            color: #333;
            font-weight: bold;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
        }

        thead {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        th {
            padding: 18px 15px;
            text-align: left;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85em;
            letter-spacing: 0.5px;
        }

        th:first-child {
            width: 50px;
            text-align: center;
        }

        th:nth-child(3),
        th:nth-child(4),
        th:nth-child(5) {
            text-align: right;
        }

        td {
            padding: 18px 15px;
            border-bottom: 1px solid #f0f0f0;
            color: #333;
            font-size: 1em;
        }

        td:first-child {
            text-align: center;
            font-weight: bold;
            color: #667eea;
        }

        td:nth-child(3),
        td:nth-child(4),
        td:nth-child(5) {
            text-align: right;
            font-family: 'Courier New', monospace;
        }

        tbody tr {
            transition: all 0.3s ease;
        }

        tbody tr:hover {
            background-color: #f8f9fa;
            transform: scale(1.01);
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        .total-section {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            color: white;
            padding: 30px;
            border-radius: 12px;
            margin: 30px 0;
            text-align: right;
            box-shadow: 0 8px 25px rgba(56, 239, 125, 0.3);
        }

        .total-section h3 {
            font-size: 2em;
            margin: 0;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
        }

        .total-section .total-label {
            font-size: 1em;
            opacity: 0.9;
            margin-bottom: 10px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .total-section .total-amount {
            font-size: 3em;
            font-weight: bold;
            font-family: 'Courier New', monospace;
        }

        .actions {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-top: 30px;
        }

        button {
            padding: 18px 30px;
            border: none;
            border-radius: 10px;
            font-size: 1.1em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .btn-pdf {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.3);
        }

        .btn-pdf:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 30px rgba(102, 126, 234, 0.5);
        }

        .btn-nueva {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
            box-shadow: 0 5px 20px rgba(245, 87, 108, 0.3);
        }

        .btn-nueva:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 30px rgba(245, 87, 108, 0.5);
        }

        button:active {
            transform: translateY(0);
        }

        .btn-icon {
            margin-right: 8px;
        }


        .resumen-items {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 20px;
            background: #f8f9fa;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .resumen-items span {
            color: #666;
            font-weight: 600;
        }

        .resumen-items strong {
            color: #333;
            font-size: 1.2em;
        }

        @media (max-width: 768px) {
            .container {
                border-radius: 0;
            }

            .header {
                padding: 30px 20px;
            }

            .header h2 {
                font-size: 1.8em;
            }

            .factura-body {
                padding: 20px;
            }

            .actions {
                grid-template-columns: 1fr;
            }

            table {
                font-size: 0.9em;
            }

            th, td {
                padding: 12px 8px;
            }

            .total-section .total-amount {
                font-size: 2em;
            }
        }

        @media print {
            body {
                background: white;
            }

            .container {
                box-shadow: none;
            }

            .actions {
                display: none;
            }
        }
    </style>

    <script>
        function confirmarNuevaFactura() {
            return confirm("¿Está seguro de crear una nueva factura?\n\nSe perderán los datos actuales.");
        }
    </script>
</head>
<body>

<div class="container">
    <div class="header">
        <h2>🧾 VIVI FUNDAS </h2>
        <p>Previsualización de Factura</p>
    </div>

    <div class="factura-body">
        <div class="info-cliente">
            <label>📋 Cliente</label>
            <div class="cliente-nombre"><%= factura.getCliente() %></div>
        </div>

        <div class="resumen-items">
            <span>📦 Productos en la factura:</span>
            <strong><%= factura.getDetalles().size() %> ítem(s)</strong>
        </div>

        <table>
            <thead>
            <tr>
                <th>#</th>
                <th>Producto</th>
                <th>Precio</th>
                <th>Cantidad</th>
                <th>Subtotal</th>
            </tr>
            </thead>
            <tbody>
            <%
                int i = 1;
                for (DetalleFactura d : factura.getDetalles()) {
            %>
            <tr>
                <td><%= i++ %></td>
                <td><%= d.getProducto() %></td>
                <td>$<%= String.format("%.2f", d.getPrecio()) %></td>
                <td><%= d.getCantidad() %></td>
                <td>$<%= String.format("%.2f", d.getSubtotal()) %></td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>

        <div class="total-section">
            <div class="total-label">Total a Pagar</div>
            <div class="total-amount">$<%= String.format("%.2f", factura.getTotal()) %></div>
        </div>

        <div class="actions">
            <form action="pdf" method="post" style="margin: 0;">
                <input type="hidden" name="cliente" value="<%= factura.getCliente() %>">

                <%
                    for (DetalleFactura d : factura.getDetalles()) {
                %>
                <input type="hidden" name="producto" value="<%= d.getProducto() %>">
                <input type="hidden" name="precio" value="<%= d.getPrecio() %>">
                <input type="hidden" name="cantidad" value="<%= d.getCantidad() %>">
                <%
                    }
                %>

                <button type="submit" class="btn-pdf">
                    <span class="btn-icon">📄</span> Descargar PDF
                </button>
            </form>

            <form action="index.jsp" method="get" onsubmit="return confirmarNuevaFactura()" style="margin: 0;">
                <button type="submit" class="btn-nueva">
                    <span class="btn-icon">➕</span> Nueva Factura
                </button>
            </form>
        </div>
    </div>
</div>

</body>
</html>

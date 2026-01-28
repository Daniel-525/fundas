<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Arias Fundas - Facturación</title>
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
            max-width: 1000px;
            margin: 0 auto;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            padding: 40px;
        }

        h1 {
            color: #667eea;
            text-align: center;
            margin-bottom: 30px;
            font-size: 2.5em;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
        }

        h3 {
            color: #333;
            margin: 25px 0 15px;
            padding-bottom: 10px;
            border-bottom: 3px solid #667eea;
            font-size: 1.3em;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            color: #555;
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 0.95em;
        }

        input[type="text"],
        input[type="number"] {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1em;
            transition: all 0.3s ease;
            background-color: #f8f9fa;
        }

        input[type="text"]:focus,
        input[type="number"]:focus {
            outline: none;
            border-color: #667eea;
            background-color: white;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .input-row {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr;
            gap: 15px;
            margin-bottom: 20px;
        }

        button {
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            font-size: 1em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        #btnAccion {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            width: 100%;
            padding: 15px;
            font-size: 1.1em;
            margin-top: 10px;
        }

        #btnAccion:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
        }

        #btnAccion:active {
            transform: translateY(0);
        }

        button[type="submit"] {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            color: white;
            width: 100%;
            padding: 18px;
            font-size: 1.2em;
            margin-top: 30px;
        }

        button[type="submit"]:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(56, 239, 125, 0.4);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
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
            padding: 15px;
            text-align: left;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85em;
            letter-spacing: 0.5px;
        }

        td {
            padding: 15px;
            border-bottom: 1px solid #f0f0f0;
            color: #333;
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

        .btn-editar {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
            padding: 8px 20px;
            border-radius: 6px;
            font-size: 0.9em;
        }

        .btn-editar:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(245, 87, 108, 0.4);
        }

        .tabla-container {
            overflow-x: auto;
            margin-top: 20px;
        }

        .empty-state {
            text-align: center;
            padding: 40px;
            color: #999;
            font-style: italic;
        }

        .card-section {
            background: #f8f9fa;
            padding: 25px;
            border-radius: 12px;
            margin-bottom: 25px;
            border: 2px solid #e9ecef;
        }

        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }

            h1 {
                font-size: 1.8em;
            }

            .input-row {
                grid-template-columns: 1fr;
            }

            table {
                font-size: 0.9em;
            }

            th, td {
                padding: 10px 8px;
            }
        }

        /* Animación de carga */
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

        .container {
            animation: fadeIn 0.5s ease;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>🧾 VIVI FUNDAS - FACTURACIÓN</h1>

    <form action="factura" method="post" onsubmit="return prepararEnvio()">

        <div class="card-section">
            <div class="form-group">
                <label>👤 Trabajador:</label>
                <input type="text" name="cliente" placeholder="Ingrese el nombre del cliente" required>
            </div>
        </div>

        <div class="card-section">
            <h3>📦 Ingresar Producto</h3>

            <div class="input-row">
                <div class="form-group">
                    <label>Producto:</label>
                    <input type="text" id="producto" placeholder="Nombre del producto">
                </div>

                <div class="form-group">
                    <label>Precio ($):</label>
                    <input type="number" step="0.01" id="precio" placeholder="0.00">
                </div>

                <div class="form-group">
                    <label>Cantidad:</label>
                    <input type="number" id="cantidad" placeholder="1">
                </div>
            </div>

            <button type="button" id="btnAccion" onclick="accionFunda()">➕ Agregar Funda</button>
        </div>

        <h3>📋 Productos Ingresados</h3>

        <div class="tabla-container">
            <table>
                <thead>
                <tr>
                    <th>#</th>
                    <th>Producto</th>
                    <th>Precio</th>
                    <th>Cantidad</th>
                    <th>Subtotal</th>
                    <th>Acción</th>
                </tr>
                </thead>
                <tbody id="listaFundas">
                <tr>
                    <td colspan="6" class="empty-state">No hay productos agregados</td>
                </tr>
                </tbody>
            </table>
        </div>

        <div id="inputsOcultos"></div>

        <button type="submit">✅ Generar Factura</button>
    </form>
</div>

<script>
    let fundas = [];
    let indiceEditar = -1;

    function accionFunda() {
        if (indiceEditar === -1) {
            agregarFunda();
        } else {
            guardarEdicion();
        }
    }

    function agregarFunda() {
        const producto = document.getElementById("producto").value.trim();
        const precio = document.getElementById("precio").value.trim();
        const cantidad = document.getElementById("cantidad").value.trim();

        if (producto === "" || precio === "" || cantidad === "") {
            alert("⚠️ Complete todos los campos del producto");
            return;
        }

        if (parseFloat(precio) <= 0 || parseInt(cantidad) <= 0) {
            alert("⚠️ El precio y la cantidad deben ser mayores a 0");
            return;
        }

        fundas.push({ producto, precio, cantidad });
        actualizarLista();
        limpiarFormulario();
    }

    function editarFunda(index) {
        const f = fundas[index];

        document.getElementById("producto").value = f.producto;
        document.getElementById("precio").value = f.precio;
        document.getElementById("cantidad").value = f.cantidad;

        indiceEditar = index;
        document.getElementById("btnAccion").innerText = "💾 Guardar Cambios";
    }

    function guardarEdicion() {
        const producto = document.getElementById("producto").value.trim();
        const precio = document.getElementById("precio").value.trim();
        const cantidad = document.getElementById("cantidad").value.trim();

        if (producto === "" || precio === "" || cantidad === "") {
            alert("⚠️ Complete todos los campos");
            return;
        }

        if (parseFloat(precio) <= 0 || parseInt(cantidad) <= 0) {
            alert("⚠️ El precio y la cantidad deben ser mayores a 0");
            return;
        }

        fundas[indiceEditar] = { producto, precio, cantidad };

        indiceEditar = -1;
        document.getElementById("btnAccion").innerText = "➕ Agregar Funda";

        actualizarLista();
        limpiarFormulario();
    }

    function actualizarLista() {
        const lista = document.getElementById("listaFundas");
        lista.innerHTML = "";

        if (fundas.length === 0) {
            lista.innerHTML = '<tr><td colspan="6" class="empty-state">No hay productos agregados</td></tr>';
            return;
        }

        fundas.forEach((f, index) => {
            const subtotal = (parseFloat(f.precio) * parseInt(f.cantidad)).toFixed(2);
            const fila = document.createElement("tr");
            fila.innerHTML =
                "<td><strong>" + (index + 1) + "</strong></td>" +
                "<td>" + f.producto + "</td>" +
                "<td>$" + parseFloat(f.precio).toFixed(2) + "</td>" +
                "<td>" + f.cantidad + "</td>" +
                "<td><strong>$" + subtotal + "</strong></td>" +
                "<td><button type='button' class='btn-editar' onclick='editarFunda(" + index + ")'>✏️ Editar</button></td>";

            lista.appendChild(fila);
        });
    }

    function limpiarFormulario() {
        document.getElementById("producto").value = "";
        document.getElementById("precio").value = "";
        document.getElementById("cantidad").value = "";
        document.getElementById("producto").focus();
    }

    function prepararEnvio() {
        if (fundas.length === 0) {
            alert("⚠️ Debe agregar al menos un producto");
            return false;
        }

        const contenedor = document.getElementById("inputsOcultos");
        contenedor.innerHTML = "";

        fundas.forEach(f => {
            contenedor.innerHTML +=
                '<input type="hidden" name="producto" value="' + f.producto + '">' +
                '<input type="hidden" name="precio" value="' + f.precio + '">' +
                '<input type="hidden" name="cantidad" value="' + f.cantidad + '">';
        });

        return true;
    }
</script>

</body>
</html>

package model;

public class DetalleFactura {

    private String producto;
    private double precio;
    private int cantidad;

    public DetalleFactura(String producto, double precio, int cantidad) {
        this.producto = producto;
        this.precio = precio;
        this.cantidad = cantidad;
    }

    public double getSubtotal() {
        return precio * cantidad;
    }

    public String getProducto() {
        return producto;
    }

    public double getPrecio() {
        return precio;
    }

    public int getCantidad() {
        return cantidad;
    }
}

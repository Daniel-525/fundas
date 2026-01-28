package model;

import java.util.ArrayList;
import java.util.List;

public class Factura {

    private String cliente;
    private List<DetalleFactura> detalles = new ArrayList<>();

    public Factura(String cliente) {
        this.cliente = cliente;
    }

    public void agregarDetalle(DetalleFactura detalle) {
        detalles.add(detalle);
    }

    public double getTotal() {
        return detalles.stream()
                .mapToDouble(DetalleFactura::getSubtotal)
                .sum();
    }

    public String getCliente() {
        return cliente;
    }

    public List<DetalleFactura> getDetalles() {
        return detalles;
    }


}

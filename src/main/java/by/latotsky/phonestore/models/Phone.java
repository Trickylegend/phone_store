package by.latotsky.phonestore.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "phones")
@Getter
@Setter
public class Phone {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String brand;

    private String model;

    private int ram;

    @Column(name = "description", columnDefinition = "text")
    private String description;

    private String type;

    private BigDecimal price;

    private double averageRating;

    @OneToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Image image;

    @OneToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private InventoryItem inventoryItem;

    private boolean isBestseller = false;

}

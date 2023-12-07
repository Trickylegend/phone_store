package by.latotsky.phonestore.models;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CartItem {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "phone_id")
    private Phone phone;

    private int quantity;

    @Column(name = "selected")
    private Boolean selected = false;

    @ManyToOne
    @JoinColumn(name = "cart_id")
    private Cart cart;

}

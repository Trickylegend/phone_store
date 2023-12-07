package by.latotsky.phonestore.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "inventory")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class InventoryItem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private int quantity;

    public void incrementQuantity(int amount) {
        this.quantity += amount;
    }

    public void decrementQuantity(int amount) throws RuntimeException {
        if (this.quantity < amount) {
            throw new RuntimeException("Not enough stock for phone");
        }
        this.quantity -= amount;
    }

    public boolean isAvailable(int amount) {
        return this.quantity >= amount;
    }
}

package by.latotsky.phonestore.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Table(name = "articles")
public class Article {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;

    private String description;

    private LocalDateTime dateOfCreated;

    @ManyToOne
    @JoinColumn(name = "author_id")
    private User author;

    @OneToOne( cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private Image preview;

    @PrePersist
    private void init() {
        dateOfCreated = LocalDateTime.now();
    }

}

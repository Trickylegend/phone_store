package by.latotsky.phonestore.models;


import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class PhoneSalesDTO {

    private Long phoneId;
    private Long totalSales;

    public PhoneSalesDTO(Long phoneId, Long totalSales) {
        this.phoneId = phoneId;
        this.totalSales = totalSales;
    }
}

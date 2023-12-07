package by.latotsky.phonestore.services;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class EmailService {


    private final JavaMailSender mailSender;

    public void sendHtmlMessage(String to, String subject, String htmlContent) throws MessagingException {
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

        helper.setFrom("auto.by.tech@mail.ru");
        helper.setTo(to);
        helper.setSubject(subject);
        helper.setText(htmlContent, true); // true означает, что это HTML

        mailSender.send(message);
    }
}

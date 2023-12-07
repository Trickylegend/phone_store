package by.latotsky.phonestore.services;

import by.latotsky.phonestore.models.Article;
import by.latotsky.phonestore.models.User;
import by.latotsky.phonestore.repositories.ArticleRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@Service
@Slf4j
@RequiredArgsConstructor
public class ArticleService {
    private final ArticleRepository articleRepository;

    private final ImageService imageService;

    @Transactional
    public boolean create(Article article, MultipartFile image, User user) {
        if (image != null && !image.isEmpty()) {
            try {
                article.setPreview(imageService.toImageEntity(image));
            } catch (IOException e) {
                log.error("Error while converting image", e);
                throw new RuntimeException(e);
            }
        }
        article.setAuthor(user);
        return articleRepository.save(article) != null;
    }

    @Transactional
    public boolean delete(Long articleId) {
        try {
            articleRepository.deleteById(articleId);
            return true;
        } catch (Exception e) {
            log.error("Error while deleting article", e);
            return false;
        }
    }

    public List<Article> findAll() {
        return articleRepository.findAll();
    }

    public Optional<Article> getById(Long articleId) {
        return articleRepository.findById(articleId);
    }

    @Transactional
    public boolean update(Long articleId, Article updatedArticle, MultipartFile image) {
        return articleRepository.findById(articleId).map(existingArticle -> {
            if (!updatedArticle.getTitle().isEmpty()) {
                existingArticle.setTitle(updatedArticle.getTitle());
            }
            if (!updatedArticle.getDescription().isEmpty()) {
                existingArticle.setDescription(updatedArticle.getDescription());
            }
            if (image != null && !image.isEmpty()) {
                try {
                    existingArticle.setPreview(imageService.toImageEntity(image));
                } catch (IOException e) {
                    log.error("Error while updating image", e);
                    return false;
                }
            }
            articleRepository.save(existingArticle);
            return true;
        }).orElseThrow(() -> new RuntimeException("Article not found"));
    }
}

package com.cms.common.core.service;
import com.cms.common.core.service.impl.MinioOssFileService;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * @author 2022/4/6 15:45
 */
public interface OssFileService {

    static OssFileService create(String endpoint, String keyId, String keySecret) {
        return new MinioOssFileService(endpoint,keyId,keySecret);
    }

    void makeBucket(String bucketName);

    List<String> listBucketNames();

    void removeBucket(String bucketName);

    /**
     * 上传文件方法
     * @param file
     * @param bucketName
     * @return
     */
    String putObject(MultipartFile file, String bucketName);

    void putObject(String bucketName, String objectName, String fileName);

    void removeObject(String bucketName, String objectName);

    String presignedGetHttpObject(String bucketName, String objectName);

    String presignedGetHttpObject(String bucketName, String objectName, int exp);

    String presignedGetChainObject(String fileId);

    String shareGetHttpObject(String bucketName, String objectName, int exp);

    void downloadFile(String bucketName, String objectName, HttpServletResponse response);
}

package com.cms.common.core.service.impl;
import cn.hutool.core.date.DateTime;
import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import com.aliyun.oss.model.*;
import com.cms.common.core.service.OssFileService;
import com.cms.common.core.utils.CoreWebUtils;
import lombok.extern.apachecommons.CommonsLog;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @author 2022/4/6 15:44
 */
@CommonsLog
public class MinioOssFileService implements OssFileService {

    private OSS ossClient;

    private static final String location ="www.thincell.cc";
    private static final int EXPIRES_TIME_SEC = 7200;

    public MinioOssFileService(String endpoint, String keyId, String keySecret) {
        try {
            this.ossClient = new OSSClientBuilder().build(endpoint,keyId,keySecret);
            log.info("初始化Oss文件服务器============================");
        } catch (Exception e) {
            e.printStackTrace();
            log.error("初始化Os配置异常: 【{}】", e.fillInStackTrace());
        }
    }

    @Override
    public void makeBucket(String bucketName) {
        try {
          ossClient.createBucket(bucketName);
        } catch (Exception e) {
            e.printStackTrace();
            log.info("创建桶异常：{}",e.fillInStackTrace());
        }
    }

    @Override
    public List<String> listBucketNames() {
        // 列出所有存储桶
        List<Bucket> bucketList = getBuckets();
        return bucketList.stream().map(bucket -> bucket.getName()).collect(Collectors.toList());
    }

    @Override
    public void removeBucket(String bucketName) {
        try {
            ossClient.deleteBucket(bucketName);
        } catch (Exception e) {
            e.printStackTrace();
            log.info("删除桶异常：{}",e.fillInStackTrace());
        }
    }

    @Override
    public String putObject(MultipartFile file, String bucketName) {
        try {
            // 创建OSSClient实例。
            // 填写本地文件的完整路径。如果未指定本地路径，则默认从示例程序所属项目对应本地路径中上传文件流。
            InputStream inputStream = file.getInputStream();
            //获取文件真实名称
            String originalFilename = file.getOriginalFilename();
            // meta设置请求头
            ObjectMetadata meta = new ObjectMetadata();
            //根据文件后缀设置响应体,这样浏览器就不会直接打开了
            meta.setContentType(CoreWebUtils.getContentType(originalFilename.substring(originalFilename.lastIndexOf(".") + 1)));
            //重命名，防止相同文件出现覆盖 生成的f4f2e1a3-391a-4d5a-9438-0c9f5d27708=》需要替换成f4f2e1a3391a4d5a94380c9f5d27708c
            String uuid = UUID.randomUUID().toString().replaceAll("-","");
            //新的文件名
            originalFilename=uuid;
            //2、把文件按照日期进行分类
            // 2021/6/30
            String datePath = new DateTime().toString("yyyy/MM/dd");
            //拼接 021/6/30/1.jpg
            originalFilename="oss/"+datePath+"/"+originalFilename;
            // oss实现上传文件
            //第一个参数：Bucket名称
            //第二个参数：上传到oss文件路径和文件名称 /zhz/avatar.txt
            ossClient.putObject(bucketName, originalFilename, inputStream,meta);
            // 关闭OSSClient。
            ossClient.shutdown();
            //把上传之后文件路径返回
            //需要把上传到阿里云oss路径手动拼接出来->https://zhz-mail.oss-cn-beijing.aliyuncs.com/WechatIMG19.jpeg
             return  "https://"+location+"/"+originalFilename;
        } catch (Exception e) {
            e.printStackTrace();
            log.info("上传文件异常：{}",e.fillInStackTrace());
        }
        return null;
    }

    @Override
    public void putObject(String bucketName, String objectName, String fileName) {
        try {
            //TODO 未完成内容
            //容器不存在，就创建
            if (!ossClient.doesBucketExist(bucketName)) {
                ossClient.createBucket(bucketName);
                CreateBucketRequest createBucketRequest = new CreateBucketRequest(bucketName);
                createBucketRequest.setCannedACL(CannedAccessControlList.PublicRead);
                ossClient.createBucket(createBucketRequest);
            }

        } catch (Exception e) {
            e.printStackTrace();
            log.info("上传本地文件异常：{}", e.fillInStackTrace());
        }
    }

    @Override
    public void removeObject(String bucketName, String objectName) {
        try {
            //删除某个模块
            ossClient.deleteObject(bucketName,objectName);
        } catch (Exception e) {
            e.printStackTrace();
            log.info("删除文件异常：{}",e.fillInStackTrace());
        }
    }

    @Override
    public String presignedGetHttpObject(String bucketName, String objectName) {
        return presignedGetHttpObject(bucketName,objectName,0);
    }

    @Override
    public String presignedGetHttpObject(String bucketName, String objectName, int exp) {
        String presignedObjectUrl = null;
        try {
            // 设置URL的过期时间
            Date expiration = new Date(System.currentTimeMillis() + 3600 * exp); // 1小时后过期
            // 生成URL请求
            GeneratePresignedUrlRequest generatePresignedUrlRequest = new GeneratePresignedUrlRequest(bucketName, objectName);
            generatePresignedUrlRequest.setExpiration(expiration);

            presignedObjectUrl = ossClient.generatePresignedUrl(generatePresignedUrlRequest).getPath();
        } catch (Exception e) {
            e.printStackTrace();
            log.error("获取HTTP文件预览地址异常:"+e.fillInStackTrace());
        }
        return presignedObjectUrl;
    }

    @Override
    public String presignedGetChainObject(String fileId) {
        //校验文件是否为空
        if (StringUtils.isEmpty(fileId) && !fileId.startsWith("http://") && !fileId.startsWith("https://")){
            return fileId;
        }
        URL url = null;
        try{
            url = new URL(fileId);
        }catch (Exception e){
            log.error("不合法的URL："+e.getMessage());
            return fileId;
        }
        String path = url.getPath();
        String[] split = path.split("/");
        String bucketName = split[1];
        Map<String, String> params = parseURLParam(fileId);
        if(!expire(params)){
            return fileId;
        }
        String bucketNamePre = "/" + bucketName;
        String objectName = path.substring(bucketNamePre.length() + 1);
        return presignedGetHttpObject(bucketName,objectName);
    }

    @Override
    public String shareGetHttpObject(String bucketName, String objectName, int exp) {
        String presignedObjectUrl = null;
        try {

        } catch (Exception e) {
            e.printStackTrace();
            log.error("获取HTTP文件预览地址异常:"+e.fillInStackTrace());
        }
        return presignedObjectUrl;
    }

    @Override
    public void downloadFile(String bucketName, String objectName, HttpServletResponse response) {
        InputStream inputStream = null;
        OutputStream outputStream = null;
        int totalSize = 0;
        try {
            // 查询对象信息
            OSSObject ossObject = ossClient.getObject(new GetObjectRequest(bucketName, objectName));
            if (ossObject !=null) {
                // 获取文件流
                inputStream =  ossObject.getObjectContent();
                // 获取文件大小
                // 此输入流在不受阻塞情况下能读取的字节数,总是0，不能用次函数：inputStream.available()
                totalSize = Math.toIntExact(ossObject.getObjectMetadata().getContentLength());
                log.info("Minio当前下载文件大小:"+ totalSize / 1024 + "KB");
                // 输出文件到浏览器
                byte[] bf = new byte[1024];
                int length;
                response.reset();
                response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(objectName.substring(objectName.lastIndexOf("/") + 1), "UTF-8"));
                response.setContentType("application/octet-stream");
                response.setHeader("Content-Length", String.valueOf(totalSize));
                response.setCharacterEncoding("UTF-8");
                outputStream = response.getOutputStream();
                // 输出文件
                while ((length = inputStream.read(bf)) > 0) {
                    outputStream.write(bf, 0, length);
                }
            }else {
                log.info("文件信息不存在!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            log.info("下载文件异常：{}",e.fillInStackTrace());
        } finally {
            // 关闭输入流
            try {
                assert inputStream != null;
                inputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
            // 关闭输出流
            assert outputStream != null;
            try {
                outputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    private List<Bucket> getBuckets() {
        List<Bucket> bucketList = new ArrayList<>();
        try {
            bucketList = ossClient.listBuckets();
        } catch (Exception e) {
            e.printStackTrace();
            log.info("列出所有存储桶异常：{}",e.fillInStackTrace());
        }
        return bucketList;
    }

    private boolean expire(Map<String, String> params){
        //获取链接有效时长 默认两小时
        String date = params.get("X-Amz-Date");
        if(StringUtils.isNotBlank(date)){
            Date exp = null;
            try {
                exp = DateUtils.parseDate(date.replaceAll("T", "").replaceAll("Z", ""), new String[]{"yyyyMMddHHmmss"});
            } catch (ParseException e) {
                e.printStackTrace();
                log.info("DateUtils parseDate is error:"+e.getMessage());
            }
            if(exp != null){
                //exp解析时间差8个小时
                exp = DateUtils.addSeconds(exp, 8 * 60 * 60 + EXPIRES_TIME_SEC);
                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String format = simpleDateFormat.format(exp);
                log.info("过期时间："+format);
                // 当exp < date时 返回true
                return exp.before(new Date());
            }
        }
        return true;
    }

    private Map<String, String> parseURLParam(String url) {
        Map<String, String> mapRequest = new HashMap<>();
        String[] arrSplit = null;
        String strUrlParam = TruncateUrlPage(url);
        if (strUrlParam == null) {
            return mapRequest;
        }
        arrSplit = strUrlParam.split("[&]");
        for (String strSplit : arrSplit) {
            String[] arrSplitEqual = null;
            arrSplitEqual = strSplit.split("[=]");
            if (arrSplitEqual.length > 1) {
                mapRequest.put(arrSplitEqual[0], arrSplitEqual[1]);
            } else {
                if (StringUtils.isNotBlank(arrSplitEqual[0])) {
                    mapRequest.put(arrSplitEqual[0], "");
                }
            }
        }
        return mapRequest;
    }

    private String TruncateUrlPage(String strURL) {
        String strAllParam = null;
        String[] arrSplit = null;
        strURL = strURL.trim();
        arrSplit = strURL.split("[?]");
        if (strURL.length() > 1) {
            if (arrSplit.length > 1) {
                if (arrSplit[1] != null) {
                    strAllParam = arrSplit[1];
                }
            }
        }
        return strAllParam;
    }
}

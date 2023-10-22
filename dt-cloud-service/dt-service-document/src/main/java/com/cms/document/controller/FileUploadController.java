package com.cms.document.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.cms.common.core.domain.SysSearchPage;
import com.cms.common.core.service.OssFileService;
import com.cms.common.tool.result.ResultUtil;
import com.cms.document.entity.FileInformationEntity;
import com.cms.document.service.FileInformationService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * @author  2022/4/7 9:30
 */
@Api(tags = "文件系统API")
@RestController
@RequestMapping("/file")
public class FileUploadController {

    private final FileInformationService fileInformationService;
    private final OssFileService ossFileService;

    public FileUploadController(OssFileService ossFileService, FileInformationService fileInformationService) {
        this.ossFileService = ossFileService;
        this.fileInformationService = fileInformationService;
    }

    @ApiOperation(value = "上传文件")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "bucket名称",name = "bucketName",required = false),
            @ApiImplicitParam(value = "文件",name = "file",required = true,allowMultiple = true,dataType = "MultipartFile")
    })
    @RequestMapping(value = "/uploadFile",headers = "content-type=multipart/form-data",method = RequestMethod.POST)
    public String uploadFile(@RequestParam(value = "file") MultipartFile file, @RequestParam String bucketName) {
        String url = ossFileService.putObject(file, bucketName);
        // 保存上传文件信息
        fileInformationService.saveFile(file,bucketName,url);
        return url;
    }

    @ApiOperation(value = "获取所有存储桶")
    @RequestMapping(value = "/listBucketNames",method = RequestMethod.GET)
    public ResultUtil<List<String>> listBucketNames() {
        return ResultUtil.success(ossFileService.listBucketNames());
    }

    @ApiOperation(value = "分页查询文件列表")
    @RequestMapping(value = "/page",method = RequestMethod.GET)
    public ResultUtil<IPage<FileInformationEntity>> page(SysSearchPage request) {
        return fileInformationService.pageSearch(request);
    }

    @ApiOperation(value = "获取文件HTTP地址")
    @RequestMapping(value = "/getUrl",method = RequestMethod.GET)
    public ResultUtil<String> getUrl(@RequestParam String bucketName, @RequestParam String objectName) {
        return ResultUtil.success(ossFileService.presignedGetHttpObject(bucketName,objectName));
    }

    @ApiOperation(value = "查看文件")
    @RequestMapping(value = "/getHttpUrl",method = RequestMethod.POST)
    public ResultUtil<String> getHttpUrl(@RequestBody FileInformationEntity informationEntity) {
        return ResultUtil.success(ossFileService.presignedGetChainObject(informationEntity.getFileUrl()));
    }

    @ApiOperation(value = "分享文件")
    @RequestMapping(value = "/shareFile",method = RequestMethod.POST)
    public ResultUtil<String> shareFile(@RequestBody FileInformationEntity informationEntity) {
        return ResultUtil.success(ossFileService.shareGetHttpObject(informationEntity.getBucket(),informationEntity.getObjectName(), Integer.parseInt(informationEntity.getExp())));
    }

    @ApiOperation(value = "删除文件")
    @RequestMapping(value = "/delFile",method = RequestMethod.POST)
    public ResultUtil<?> delFile(@RequestBody FileInformationEntity informationEntity) {
        ossFileService.removeObject(informationEntity.getBucket(), informationEntity.getObjectName());
        fileInformationService.removeObject(informationEntity.getBucket(), informationEntity.getObjectName());
        return ResultUtil.success();
    }

    @ApiOperation(value = "下载文件")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "bucket名称",name = "bucket",required = true),
            @ApiImplicitParam(value = "objectName名称",name = "objectName",required = true)
    })
    @RequestMapping(value = "/downloadFile",method = RequestMethod.GET)
    public void downloadFile(@RequestParam String bucket, @RequestParam String objectName, HttpServletResponse response) {
        ossFileService.downloadFile(bucket, objectName,response);
    }

    @ApiOperation(value = "上传文件测试")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "文件",name = "file",required = true,allowMultiple = true,dataType = "MultipartFile")
    })
    @RequestMapping(value = "/uploadFileTest",headers = "content-type=multipart/form-data",method = RequestMethod.POST)
    @CrossOrigin(origins = "*")
    public ResultUtil<?> uploadFile(@RequestParam(value = "file") MultipartFile file) {
        String url = ossFileService.putObject(file, null);
        // 保存上传文件信息
        fileInformationService.saveFile(file,null,url);
        return ResultUtil.success(url);
    }

    @ApiOperation(value = "获取文件数据")
    @RequestMapping(value = "/list",method = RequestMethod.GET)
    @CrossOrigin(origins = "*")
    public ResultUtil<List<FileInformationEntity>> list() {
        return ResultUtil.success(fileInformationService.list());
    }
}

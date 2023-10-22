package com.cms.manage.controller;

import com.cms.common.tool.result.ResultUtil;
import com.cms.manage.entity.SysDepartmentEntity;
import com.cms.manage.service.SysDeptService;
import com.cms.manage.vo.SysDeptRequest;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @date 2021/6/13 12:02
 */
@Api(tags = "系统部门信息API")
@RestController
@RequestMapping("/dept")
public class SysDeptController {

    private final SysDeptService sysDeptService;

    public SysDeptController(SysDeptService sysDeptService) {
        this.sysDeptService = sysDeptService;
    }

    @ApiOperation(value = "查询部门树列表")
    @RequestMapping(value = "/list",method = RequestMethod.GET)
    public ResultUtil<List<SysDepartmentEntity>> list(SysDeptRequest request){
        return sysDeptService.queryList(request);
    }

    @ApiOperation(value = "添加部门")
    @RequestMapping(value = "/save",method =RequestMethod.POST)
    public ResultUtil<SysDepartmentEntity> generateId(@RequestBody SysDepartmentEntity sysDepartmentEntity) {
        return sysDeptService.saveDept(sysDepartmentEntity);
    }

    @ApiOperation(value = "批量删除部门")
    @RequestMapping(value = "/bath_delete",method = RequestMethod.DELETE)
    public ResultUtil<?> deleteBath(@RequestBody long[] ids) {
        return sysDeptService.deleteBath(ids);
    }


    @ApiOperation(value = "根据id查询部门")
    @RequestMapping(value = "/getById/{id}",method = RequestMethod.GET)
    public ResultUtil<SysDepartmentEntity> getById(@PathVariable String id){
        return sysDeptService.getDeptById(id);
    }


    @ApiOperation(value = "删除系统部门")
    @RequestMapping(value = "/delete/{id}",method = RequestMethod.DELETE)
    public ResultUtil<SysDepartmentEntity> delete(@PathVariable String id){
        return sysDeptService.deleteDept(id);
    }
}

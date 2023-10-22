package com.cms.manage.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.cms.common.core.domain.SysSearchPage;
import com.cms.common.log.annotation.Log;
import com.cms.common.log.enums.BusinessType;
import com.cms.common.tool.result.ResultUtil;
import com.cms.manage.entity.SysOperatorEntity;
import com.cms.manage.service.SysOperatorService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @author  2022/1/12 15:59
 */
@Api(tags = "操作员管理API")
@RestController
@RequestMapping(value = "/operator")
public class SysOperatorController {

    private final SysOperatorService sysOperatorService;

    public SysOperatorController(SysOperatorService sysOperatorService) {
        this.sysOperatorService = sysOperatorService;
    }

    @ApiOperation(value = "分页查询用户列表")
    @RequestMapping(value = "/page",method = RequestMethod.GET)
    public ResultUtil<IPage<SysOperatorEntity>> page(SysSearchPage request) {
        return sysOperatorService.pageSearch(request);
    }

    @Log(title = "编辑操作员日志记录", businessType = BusinessType.UPDATE)
    @ApiOperation(value = "添加操作员")
    @RequestMapping(value = "/save",method = RequestMethod.POST)
    public ResultUtil<SysOperatorEntity> save(@RequestBody SysOperatorEntity request) {
        return sysOperatorService.saveOperator(request);
    }

    @ApiOperation(value = "根据id获取操作员信息")
    @RequestMapping(value = "/getById/{id}",method = RequestMethod.GET)
    public ResultUtil<SysOperatorEntity> getById(@PathVariable Long id) {
        SysOperatorEntity operator = sysOperatorService.getById(id);
        return ResultUtil.success(operator);
    }

    @Log(title = "删除操作员日志记录", businessType = BusinessType.DELETE)
    @ApiOperation(value = "删除操作员")
    @RequestMapping(value = "/delete/{id}",method = RequestMethod.DELETE)
    public ResultUtil<SysOperatorEntity> delete(@PathVariable String id) {
        return sysOperatorService.deleteOperatorById(id);
    }

    @Log(title = "批量删除操作员日志记录", businessType = BusinessType.DELETE)
    @ApiOperation(value = "批量删除操作员")
    @RequestMapping(value = "/delete_bath",method = RequestMethod.DELETE)
    public ResultUtil<?> deleteBath(@RequestBody long[] ids) {
        return sysOperatorService.deleteBath(ids);
    }

    @ApiOperation(value = "禁用/启用操作员状态")
    @RequestMapping(value = "/update_enabled/{id}/{enabled}",method = RequestMethod.DELETE)
    public ResultUtil<?> updateEnabled(@PathVariable Long id, @PathVariable Boolean enabled) {
        return sysOperatorService.updateEnabled(id,enabled);
    }

    @ApiOperation(value = "获取所有操作员信息")
    @RequestMapping(value = "/findAll",method = RequestMethod.GET)
    public ResultUtil<List<SysOperatorEntity>> findAll() {
        return ResultUtil.success(sysOperatorService.list());
    }

    @Log(title = "更新个人信息日志记录", businessType = BusinessType.UPDATE)
    @ApiOperation(value = "更新个人信息")
    @RequestMapping(value = "/updateMyInfo",method = RequestMethod.POST)
    public ResultUtil<SysOperatorEntity> updateMyInfo(@RequestBody SysOperatorEntity request) {
        sysOperatorService.updateById(request);
        return ResultUtil.success();
    }

}

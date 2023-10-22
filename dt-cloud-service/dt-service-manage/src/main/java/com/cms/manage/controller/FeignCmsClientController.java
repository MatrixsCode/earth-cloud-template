package com.cms.manage.controller;

import com.api.manage.feign.LogFeignClientService;
import com.api.manage.feign.OauthFeignClientService;
import com.cms.common.tool.domain.SecurityClaimsUserEntity;
import com.cms.common.tool.domain.SysLoginLogVoEntity;
import com.cms.common.tool.domain.SysOperatorLogVoEntity;
import com.cms.common.tool.result.ResultUtil;
import com.cms.manage.entity.SysLogLoginEntity;
import com.cms.manage.entity.SysLogOperatorEntity;
import com.cms.manage.service.SysLogLoginService;
import com.cms.manage.service.SysLogOperatorService;
import com.cms.manage.service.SysOperatorService;
import io.swagger.annotations.Api;
import org.springframework.beans.BeanUtils;
import org.springframework.web.bind.annotation.RestController;

import static com.cms.common.tool.enums.AuthenticationIdentityEnum.*;

/**
 * @author  2022/1/7 16:20
 */
@Api(tags = "远程调用接口API")
@RestController
public class FeignCmsClientController implements OauthFeignClientService, LogFeignClientService {

    private final SysLogLoginService sysLogLoginService;
    private final SysLogOperatorService sysOperatorLogService;
    private final SysOperatorService sysOperatorService;

    public FeignCmsClientController(SysOperatorService sysOperatorService, SysLogOperatorService sysOperatorLogService, SysLogLoginService sysLogLoginService) {
        this.sysOperatorService = sysOperatorService;
        this.sysOperatorLogService = sysOperatorLogService;
        this.sysLogLoginService = sysLogLoginService;
    }

    @Override
    public ResultUtil<SecurityClaimsUserEntity> loadUserByUsername(String username) {
        return sysOperatorService.oauthAuthenticationByAccount(username,USERNAME);
    }

    @Override
    public void saveLoginLog(SysLoginLogVoEntity sysLoginLogVoEntity) {
        SysLogLoginEntity sysLogLoginEntity = new SysLogLoginEntity();
        BeanUtils.copyProperties(sysLoginLogVoEntity,sysLogLoginEntity);
        sysLogLoginService.saveLoginLog(sysLogLoginEntity);
    }

    @Override
    public ResultUtil<SysOperatorLogVoEntity> saveOprLog(SysOperatorLogVoEntity sysOperatorLogVoEntity) {
        SysLogOperatorEntity sysOperatorLogEntity = new SysLogOperatorEntity();
        BeanUtils.copyProperties(sysOperatorLogVoEntity,sysOperatorLogEntity);
        return sysOperatorLogService.saveOperatorLog(sysOperatorLogEntity);
    }

    @Override
    public ResultUtil<Long> findLoginLogCount() {
        return ResultUtil.success(sysLogLoginService.count());
    }
}

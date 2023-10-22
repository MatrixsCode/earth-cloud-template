package com.api.manage.feign;

import com.api.manage.factory.LogFeignClientFallback;
import com.cms.common.tool.domain.SysLoginLogVoEntity;
import com.cms.common.tool.domain.SysOperatorLogVoEntity;
import com.cms.common.tool.result.ResultUtil;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

import static com.api.common.ApiConstants.APPLICATION_MANAGE_API_AFFIX;
import static com.api.common.ApiConstants.APPLICATION_NAME_MANAGE;

/**
 * @author 2022/2/11 17:39
 */
@Service
@FeignClient(value = APPLICATION_NAME_MANAGE, fallbackFactory = LogFeignClientFallback.class)
public interface LogFeignClientService {
    @RequestMapping(value = APPLICATION_MANAGE_API_AFFIX + "/saveLoginLog",method = RequestMethod.POST)
    void saveLoginLog(@RequestBody SysLoginLogVoEntity sysLoginLogVoEntity);

    @RequestMapping(value = APPLICATION_MANAGE_API_AFFIX + "/saveOprLog",method = RequestMethod.POST)
    ResultUtil<SysOperatorLogVoEntity> saveOprLog(@RequestBody SysOperatorLogVoEntity sysOperatorLogVoEntity);

    @RequestMapping(value = APPLICATION_MANAGE_API_AFFIX + "/findLoginLogCount",method = RequestMethod.POST)
    ResultUtil<Long> findLoginLogCount();
}

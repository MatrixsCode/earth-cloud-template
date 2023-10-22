package com.cms.auth.service.impl;

import com.api.manage.feign.LogFeignClientService;
import com.cms.auth.service.LogFeignService;
import com.cms.common.core.utils.CoreWebUtils;
import com.cms.common.jdbc.config.IdGeneratorConfig;
import com.cms.common.tool.domain.SecurityClaimsUserEntity;
import com.cms.common.tool.domain.SysLoginLogVoEntity;
import eu.bitwalker.useragentutils.Browser;
import eu.bitwalker.useragentutils.OperatingSystem;
import eu.bitwalker.useragentutils.UserAgent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * @author 2022/1/25 13:58
 */
@Service
public class LogFeignServiceImpl implements LogFeignService {

    @Autowired
    private IdGeneratorConfig idGeneratorConfig;
    @Autowired
    private LogFeignClientService logFeignClientService;

    @Override
    public void sendLoginLog(HttpServletRequest request, SecurityClaimsUserEntity securityClaimsUser, boolean flag) {
        String agent = request.getHeader("User-Agent");
        // 解析agent字符串
        UserAgent userAgent = UserAgent.parseUserAgentString(agent);
        // 获取浏览器对象
        Browser browser = userAgent.getBrowser();
        // 获取操作系统对象
        OperatingSystem operatingSystem = userAgent.getOperatingSystem();
        String message =  securityClaimsUser.getUsername() + "在：" + LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")) + " 点击了登录";
        SysLoginLogVoEntity buildObject = SysLoginLogVoEntity.builder()
                .messageId(String.valueOf(idGeneratorConfig.nextId(Object.class)))
                .loginIp(CoreWebUtils.getIpAddress(request))
                .loginUserName(securityClaimsUser.getUsername())
                .title(message)
                .operatingSystem(operatingSystem.getName())
                .status(1)
                .type(flag ? 1 : 2)
                .browser(browser.getName())
                .message("写入登录日志")
                .build();
        // 远程调用接口
        logFeignClientService.saveLoginLog(buildObject);
    }
}

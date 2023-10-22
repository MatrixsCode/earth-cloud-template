package com.cms.common.core.utils;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author 2022/1/21 16:41
 */
public class CoreWebUtils {

    public static HttpServletRequest currentRequest() {
        RequestAttributes requestAttributes = RequestContextHolder.currentRequestAttributes();
        return ((ServletRequestAttributes) requestAttributes).getRequest();
    }

    public static HttpServletResponse currentResponse() {
        RequestAttributes requestAttributes = RequestContextHolder.currentRequestAttributes();
        return ((ServletRequestAttributes) requestAttributes).getResponse();
    }

    public static String getIpAddress(HttpServletRequest request) {
        String[] ips = getIpAddresses(request);
        if(ips.length > 0) {
            return ips[0];
        }
        return null;
    }

    public static String[] getIpAddresses(HttpServletRequest request) {
        String ip = request.getHeader("x-forwarded-for");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_CLIENT_IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return StringUtils.split(ip,",");
    }

    public static String getContentType(String FilenameExtension) {
        if ("bmp".equalsIgnoreCase(FilenameExtension)) {
            return "image/bmp";
        }
        if ("gif".equalsIgnoreCase(FilenameExtension)) {
            return "image/gif";
        }
        if ("jpeg".equalsIgnoreCase(FilenameExtension)
                || "jpg".equalsIgnoreCase(FilenameExtension)
                || "png".equalsIgnoreCase(FilenameExtension)) {
            return "image/jpg";
        }
        if ("html".equalsIgnoreCase(FilenameExtension)) {
            return "text/html";
        }

        if ("mp3".equalsIgnoreCase(FilenameExtension)) {
            return "audio/mp3";
        }
        if ("mp4".equalsIgnoreCase(FilenameExtension)) {
            return "video/mp4";
        }
        if ("pdf".equalsIgnoreCase(FilenameExtension)) {
            return "application/pdf";
        }
        return "application/octet-stream";
    }

}

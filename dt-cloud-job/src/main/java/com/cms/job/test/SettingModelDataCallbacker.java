package com.cms.job.test;

/**
 * @author  2022/3/28 17:06
 */
@FunctionalInterface
public interface SettingModelDataCallbacker {
    void callback(Object old_value,Object new_value) throws Exception;
}

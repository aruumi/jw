package egovframework.com.mes.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.servlet.ModelAndView;

public interface MesCommonService {

	public ModelAndView selectDataListWithJsonView(List<Map<String, Object>> dataList) throws Exception;
	public ModelAndView selectDataListWithJsonView(Map<String, Object> dataList) throws Exception;
	public ModelAndView selectDataListWithJsonView(Object dataList) throws Exception;
}

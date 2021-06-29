package egovframework.com.mes.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.mes.service.MesCommonService;

@Service("MesCommonService")
public class MesCommonServiceImpl implements MesCommonService {

	@Override
	public ModelAndView selectDataListWithJsonView(List<Map<String, Object>> dataList) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
		
		try {
			mav.addObject("result", true);
			mav.addObject("item", dataList);
		} catch(Exception e) {
			e.printStackTrace();
			mav.addObject("result", false);
		}
		
		return mav;
	}

	@Override
	public ModelAndView selectDataListWithJsonView(Map<String, Object> dataList) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
		
		try {
			mav.addObject("result", true);
			mav.addObject("item", dataList);
		} catch(Exception e) {
			e.printStackTrace();
			mav.addObject("result", false);
		}
		
		return mav;
	}

	@Override
	public ModelAndView selectDataListWithJsonView(Object dataList) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
		
		try {
			mav.addObject("result", true);
			mav.addObject("item", dataList);
		} catch(Exception e) {
			e.printStackTrace();
			mav.addObject("result", false);
		}
		
		return mav;
	}
}

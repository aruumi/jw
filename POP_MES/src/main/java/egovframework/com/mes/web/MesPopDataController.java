package egovframework.com.mes.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.mes.service.MesCommonService;
import egovframework.com.mes.service.MesPopService;
import egovframework.com.utl.fcc.service.EgovStringUtil;

@Controller
public class MesPopDataController {

	@Resource(name="MesPopService")
	private MesPopService mesPopService;
	
	@Resource(name="MesCommonService")
	private MesCommonService mesCommonService;
	
	@RequestMapping(value = "/mes/pop/data/selectProdWorkOrderList.do")
	public ModelAndView selectProdWorkOrderList(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> paramMap) throws Exception {
		return mesCommonService.selectDataListWithJsonView(mesPopService.selectMesProdWorkOrderList(paramMap));
	}
	
	@RequestMapping(value = "/mes/pop/data/selectProdWorkOrderItem.do")
	public ModelAndView selectProdWorkOrderItem(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> paramMap) throws Exception {
		return mesCommonService.selectDataListWithJsonView(mesPopService.selectMesProdWorkOrderItem(paramMap));
	}
	
	@RequestMapping(value = "/mes/pop/data/selectMesWorkerList.do")
	public ModelAndView selectMesWorkEmpList(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> paramMap) throws Exception {
		return mesCommonService.selectDataListWithJsonView(mesPopService.selectMesWorkerList(paramMap));
	}
	
	@RequestMapping(value = "/mes/pop/data/selectMesProcessLineList.do")
	public ModelAndView selectMesProcessLineList(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> paramMap) throws Exception {
		return mesCommonService.selectDataListWithJsonView(mesPopService.selectMesProcessLineList(paramMap));
	}
	
	@RequestMapping(value = "/mes/pop/data/selectMesCommonCodeList.do")
	public ModelAndView selectMesCommonCodeList(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> paramMap) throws Exception {
		return mesCommonService.selectDataListWithJsonView(mesPopService.selectMesCommonCodeList(paramMap));
	}
	
	@RequestMapping(value = "/mes/pop/data/changeProdWorkItem.do")
	public ModelAndView updateMesPopItem(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> paramMap) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
		String state = EgovStringUtil.isNullToString(paramMap.get("changeState"));
		
		try {
			switch(state) {
				case "START":
					mesPopService.startProdWorkItem(paramMap);
				break;
				case "PAUSE":
					mesPopService.pauseProdWorkItem(paramMap);
				break;
				case "END":
					mesPopService.endProdWorkItem(paramMap);
				break;
			}
			mav.addObject("result", true);
		} catch(Exception e) {
			e.printStackTrace();
			mav.addObject("result", false);
		}
		
		return mav;
	}
}

package egovframework.com.mes.web;

import java.util.Arrays;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.mes.service.MesPopPopupService;

@Controller
public class MesPopPopupDataController {

	@Resource(name="MesPopPopupService")
	private MesPopPopupService mesPopPopupService;
	
	@RequestMapping(value = "/mes/pop/popup/data/selectCheckProdValidItem.do")
	public ModelAndView selectCheckProdValidItem(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> paramMap) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
		
		//mav.addObject("mtrl", mesPopPopupService.selectCheckMtrlItem(paramMap));
		
		int mtrlYn = mesPopPopupService.selectCheckMtrlItem(paramMap);
		
		if(mtrlYn <= 0) {
			mav.addObject("result", false);
			mav.addObject("errMsg", "존재하지 않는 자재코드입니다.");
			return mav;
		}
			
		
		try {
			mav.addObject("result", true);

			mav.addObject("item", mesPopPopupService.selectCheckProdValidItem(paramMap));
		} catch(Exception e) {
			e.printStackTrace();
			mav.addObject("result", false);
		}
		
		return mav;
	}
	
	@RequestMapping(value = "/mes/pop/popup/data/selectMtrlItemOnLine.do")
	public ModelAndView selectMtrlItemOnLine(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> paramMap) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
		
		try {
			mav.addObject("result", true);
			mav.addObject("item", mesPopPopupService.selectMtrlItemOnLine(paramMap));
		} catch(Exception e) {
			e.printStackTrace();
			mav.addObject("result", false);
		}
		
		return mav;
	}
	
	@RequestMapping(value = "/mes/pop/popup/data/updateMoveLineProdItemQty.do")
	public ModelAndView updateMoveLineProdItemQty(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> paramMap) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
		
		try {
			mav.addObject("result", true);
			paramMap.put("moveLineList", Arrays.asList(request.getParameterValues("moveLineList[]")));
			
			mesPopPopupService.updateMoveLineProdItemQty(paramMap);
		} catch(Exception e) {
			e.printStackTrace();
			mav.addObject("result", false);
		}
		
		return mav;
	}
}


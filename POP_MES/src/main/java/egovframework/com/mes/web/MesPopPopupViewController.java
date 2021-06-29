package egovframework.com.mes.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MesPopPopupViewController {

	@RequestMapping(value = "/mes/pop/popup/prodEndItem.do")
	public ModelAndView endProdItem(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ModelAndView("egovframework/com/mes/popup/end_prod_item_popup");
	}

	@RequestMapping(value = "/mes/pop/popup/prodPauseItem.do")
	public ModelAndView pauseProdItem(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ModelAndView("egovframework/com/mes/popup/pause_prod_item_popup");
	}
	
	@RequestMapping(value = "/mes/pop/popup/checkProdValidItem.do")
	public ModelAndView checkProdValidItemAction(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ModelAndView("egovframework/com/mes/popup/check_prod_valid_popup");
	}
	
	@RequestMapping(value = "/mes/pop/popup/processControlValidItem.do")
	public ModelAndView processControlValidItemAction(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ModelAndView("egovframework/com/mes/popup/process_control_valid_popup");
	}
}

package egovframework.com.mes.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MesPopViewController {

	@RequestMapping(value = "/mes/pop/page/main.do")
	public ModelAndView getMesPopView(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ModelAndView("egovframework/com/mes/pop_main_view");
	}
}

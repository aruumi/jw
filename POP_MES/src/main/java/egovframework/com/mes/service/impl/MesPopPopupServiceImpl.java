package egovframework.com.mes.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.mes.service.MesPopPopupService;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.com.utl.hbz.DateUtil;


@Service("MesPopPopupService")
public class MesPopPopupServiceImpl implements MesPopPopupService {

	@Resource(name="MesPopPopupDAO")
	private MesPopPopupDAO mesPopPopupDAO;
	
	@Override
	public int selectCheckProdValidItem(Map<String, Object> paramMap) throws Exception {
		Map<String, Object> checkProdValidItem = mesPopPopupDAO.selectCheckProdValidItem(paramMap);
		
		return (int) checkProdValidItem.get("CNT");
	}

	@Override
	public List<Map<String, Object>> selectMtrlItemOnLine(Map<String, Object> paramMap) throws Exception {
		return mesPopPopupDAO.selectMtrlItemOnLine(paramMap);
	}

	@SuppressWarnings("unchecked")
	@Override
	public void updateMoveLineProdItemQty(Map<String, Object> paramMap) throws Exception {
		String currentDate = DateUtil.getTodayDate("yyyyMMddHHmmss");
		String prodEmpNo = EgovStringUtil.isNullToString(paramMap.get("prodEmpNo"));
		
		List<String> moveLineList = (List<String>) paramMap.get("moveLineList");
		List<String> updateLineList = new ArrayList<>();
		updateLineList.addAll(moveLineList);
		updateLineList.add(EgovStringUtil.isNullToString(paramMap.get("workLine")));
		
		paramMap.put("updateLineList", updateLineList);
		paramMap.put("insuser", prodEmpNo);
		paramMap.put("insdttm", currentDate);
		paramMap.put("upduser", prodEmpNo);
		paramMap.put("upddttm", currentDate);

		mesPopPopupDAO.deleteLineProdItemQty(paramMap);
		mesPopPopupDAO.insertLineProdItemQty(paramMap);
	}

	@Override
	public int selectCheckMtrlItem(Map<String, Object> paramMap) throws Exception  {
		Map<String, Object> checkProdValidItem = mesPopPopupDAO.selectCheckMtrl(paramMap);
		
		return (int) checkProdValidItem.get("CNT");
	}
	
}

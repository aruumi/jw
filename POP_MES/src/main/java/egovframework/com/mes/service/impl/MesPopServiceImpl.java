package egovframework.com.mes.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.transaction.Transactional;

import org.hamcrest.core.SubstringMatcher;
import org.springframework.stereotype.Service;

import egovframework.com.mes.service.MesPopService;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.com.utl.hbz.DateUtil;

@Service("MesPopService")
public class MesPopServiceImpl implements MesPopService {

	@Resource(name="MesPopDAO")
	private MesPopDAO mesPopDAO;
	
	@Override
	public List<Map<String, Object>> selectMesProdWorkOrderList(Map<String, Object> paramMap) throws Exception {
		return mesPopDAO.selectMesProdWorkOrderList(paramMap); 
	}

	@Override
	public Map<String, Object> selectMesProdWorkOrderItem(Map<String, Object> paramMap) throws Exception {
		return mesPopDAO.selectMesProdWorkOrderItem(paramMap);
	}

	@Override
	public void updateMesPopItem(Map<String, Object> paramMap) throws Exception {
		mesPopDAO.updateMesPopItem(paramMap);
	}
	
	public List<Map<String, Object>> selectMesProcessLineList(Map<String, Object> paramMap) throws Exception {
		return mesPopDAO.selectMesProcessLineList(paramMap);
	}
	
	public List<Map<String, Object>> selectMesWorkerList(Map<String, Object> paramMap) throws Exception {
		return mesPopDAO.selectMesWorkerList(paramMap);
	}
	
	public List<Map<String, Object>> selectMesCommonCodeList(Map<String, Object> paramMap) throws Exception {
		return mesPopDAO.selectMesCommonCodeList(paramMap);
	}

	@Transactional
	@Override
	public void startProdWorkItem(Map<String, Object> paramMap) throws Exception {
		String currentDate = DateUtil.getTodayDate("yyyyMMddHHmmss");
		String prodEmpNo = EgovStringUtil.isNullToString(paramMap.get("prodEmpNo"));
		paramMap.put("prodStartDttm", currentDate);
		paramMap.put("prodStatus", "WD");
		paramMap.put("upduser", prodEmpNo);
		paramMap.put("upddttm", currentDate);
		
		mesPopDAO.updateMesPopItem(paramMap);
	}

	@Transactional
	@Override
	public void pauseProdWorkItem(Map<String, Object> paramMap) throws Exception {
		String currentDate = DateUtil.getTodayDate("yyyyMMddHHmmss");
		String prodEmpNo = EgovStringUtil.isNullToString(paramMap.get("prodEmpNo"));
		paramMap.put("prodStprDttm", currentDate);
		paramMap.put("prodStatus", "WA");
		paramMap.put("upduser", prodEmpNo);
		paramMap.put("upddttm", currentDate);
		
		mesPopDAO.updateMesPopItem(paramMap);
	}

	@Transactional
	@Override
	public void endProdWorkItem(Map<String, Object> paramMap) throws Exception {
		String currentDate = DateUtil.getTodayDate("yyyyMMddHHmmss");
		String prodEmpNo = EgovStringUtil.isNullToString(paramMap.get("prodEmpNo"));
		String bomCheckYn = EgovStringUtil.isNullToString(paramMap.get("bomCheckYn"));
		
		
		paramMap.put("prodEntDate", DateUtil.getTodayDate("yyyyMMdd"));
		paramMap.put("prodEndDttm", currentDate);
		paramMap.put("prodStatus", "WX");
		paramMap.put("insuser", prodEmpNo);
		paramMap.put("insdttm", currentDate);
		paramMap.put("upduser", prodEmpNo);
		paramMap.put("upddttm", currentDate);
		paramMap.put("entDate", currentDate.substring(7));
		
		mesPopDAO.updateMesPopItem(paramMap);
		insertProcQualityItem(paramMap);
		insertProcInspectItem(paramMap);
		insertProdQualityItem(paramMap);
		insertProdstockItem(paramMap);
		
		if(bomCheckYn.equals("Y")) {
			//BOM CHECK=N 이면 공정재고에서 재고빠지지않음 ->보완사항있는지 확인 필요
			updateProcstock(paramMap);//공정재고 수정
		}
		
	}



	private void insertProdQualityItem(Map<String, Object> paramMap) {
		
		int maxSeq = mesPopDAO.selectProdqualitySeqno(paramMap);
		paramMap.put("pqSeqno", maxSeq);
		mesPopDAO.insertProdQualityItem(paramMap);
		
	}

	private void insertProcQualityItem(Map<String, Object> paramMap) throws Exception {
		mesPopDAO.insertProcQualityItem(paramMap);
	}
	
	private void insertProcInspectItem(Map<String, Object> paramMap) throws Exception {
		mesPopDAO.insertProcInspectItem(paramMap);
	}
	
	private void insertProdstockItem(Map<String, Object> paramMap) throws Exception {

		int maxSeq = mesPopDAO.selectProdstockSeqno(paramMap);
		paramMap.put("seqno", maxSeq);
		//gg
		mesPopDAO.insertProdstockItem(paramMap);
	
	}
	
	private void updateProcstock(Map<String, Object> paramMap) {
	
		List<Map<String, Object>> bomList;
		
		bomList = mesPopDAO.selectByBomToStockList(paramMap);

		for(int i=0; i < bomList.size() ; i++) {
		
			bomList.get(i).put("prodLineCd", paramMap.get("prodLineCd"));
			mesPopDAO.updateProcstock(bomList.get(i));
		}
		
	}
}



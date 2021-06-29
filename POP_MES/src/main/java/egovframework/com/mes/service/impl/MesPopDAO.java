package egovframework.com.mes.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("MesPopDAO")
public class MesPopDAO extends EgovComAbstractDAO {
	public List<Map<String, Object>> selectMesProdWorkOrderList(Map<String, Object> paramMap) throws Exception {
		return selectList("MesPopDAO.selectMesProdWorkOrderList", paramMap);
	}
	
	public Map<String, Object> selectMesProdWorkOrderItem(Map<String, Object> paramMap) throws Exception {
		return selectOne("MesPopDAO.selectMesProdWorkOrderItem", paramMap);
	}
	
	public void updateMesPopItem(Map<String, Object> paramMap) throws Exception {
		update("MesPopDAO.updateMesPopItem", paramMap);
	}
	
	public List<Map<String, Object>> selectMesProcessLineList(Map<String, Object> paramMap) throws Exception {
		return selectList("MesPopDAO.selectMesProcessLineList", paramMap);
	}
	
	public List<Map<String, Object>> selectMesWorkerList(Map<String, Object> paramMap) throws Exception {
		return selectList("MesPopDAO.selectMesWorkerList", paramMap);
	}
	
	public List<Map<String, Object>> selectMesCommonCodeList(Map<String, Object> paramMap) throws Exception {
		return selectList("MesPopDAO.selectMesCommonCodeList", paramMap);
	}
	
	public List<Map<String, Object>> processControlValidItem(Map<String, Object> paramMap) throws Exception {
		return selectList("MesPopDAO.processControlValidItem", paramMap);
	}	
	public void insertProcQualityItem(Map<String, Object> paramMap) {
		insert("MesPopDAO.insertProcQualityItem", paramMap);
	}

	public void insertProcInspectItem(Map<String, Object> paramMap) {
		insert("MesPopDAO.insertProcInspectItem", paramMap);
	}

	public void insertProdstockItem(Map<String, Object> paramMap ) {
		insert("MesPopDAO.insertProdstockItem", paramMap);
	
	}

	public int selectProdstockSeqno(Map<String, Object> paramMap) {
		return selectOne("MesPopDAO.selectProdstockSeqno",paramMap);
	}

	public void updateProcstock(Map<String, Object> paramMap) {
		update("MesPopDAO.updateProcstock", paramMap);
		
	}

	public List<Map<String, Object>> selectByBomToStockList(Map<String, Object> paramMap) {
		return selectList("MesPopDAO.selectByBomToStockList", paramMap);
	}

	public void insertProdQualityItem(Map<String, Object> paramMap) {
		insert("MesPopDAO.insertProdQualityItem", paramMap);
	}

	public int selectProdqualitySeqno(Map<String, Object> paramMap) {
		return selectOne("MesPopDAO.selectProdqualitySeqno",paramMap);
	}
}

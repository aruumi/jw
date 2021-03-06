package egovframework.com.mes.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("MesPopPopupDAO")
public class MesPopPopupDAO extends EgovComAbstractDAO {
	
	public Map<String, Object> selectCheckProdValidItem(Map<String, Object> paramMap) throws Exception {
		return selectOne("MesPopPopUpDAO.selectCheckProdValidItem", paramMap);
	}

	/**
	 * 공정자재 정보 조회
	 * @param 라인 정보 List, 자재코드
	 * @return 공정 자재에 대한 재고 
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectMtrlItemOnLine(Map<String, Object> paramMap) throws Exception {
		return selectList("MesPopPopUpDAO.selectMtrlItemOnLine", paramMap);
	}
	
	/**
	 * 공정자재 사용 처리
	 * @param 받을 라인 코드, 넘겨줄 라인 코드 List, 자재코드
	 * @throws Exception
	 */
	public void deleteLineProdItemQty(Map<String, Object> paramMap) throws Exception {
		delete("MesPopPopUpDAO.deleteLineProdItemQty", paramMap);
	}
	
	/**
	 * 공정자재 생성 처리
	 * @param 받을 라인 코드, 넘겨줄 라인 코드 List, 자재코드, 넘겨받을 자재 수
	 * @throws Exception
	 */
	public void insertLineProdItemQty(Map<String, Object> paramMap) throws Exception {
		insert("MesPopPopUpDAO.insertLineProdItemQty", paramMap);
	}

	public Map<String, Object> selectCheckMtrl(Map<String, Object> paramMap) {
		return selectOne("MesPopPopUpDAO.selectCheckMtrl", paramMap);
	}
}

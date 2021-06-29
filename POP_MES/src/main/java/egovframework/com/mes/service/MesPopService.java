package egovframework.com.mes.service;

import java.util.List;
import java.util.Map;

public interface MesPopService {

	public List<Map<String, Object>> selectMesProdWorkOrderList(Map<String, Object> paramMap) throws Exception;
	public Map<String, Object> selectMesProdWorkOrderItem(Map<String, Object> paramMap) throws Exception;
	public void updateMesPopItem(Map<String, Object> paramMap) throws Exception;
	public List<Map<String, Object>> selectMesProcessLineList(Map<String, Object> paramMap) throws Exception;
	public List<Map<String, Object>> selectMesWorkerList(Map<String, Object> paramMap) throws Exception;
	public List<Map<String, Object>> selectMesCommonCodeList(Map<String, Object> paramMap) throws Exception;
	public void startProdWorkItem(Map<String, Object> paramMap) throws Exception;
	public void pauseProdWorkItem(Map<String, Object> paramMap) throws Exception;
	public void endProdWorkItem(Map<String, Object> paramMap) throws Exception;
}

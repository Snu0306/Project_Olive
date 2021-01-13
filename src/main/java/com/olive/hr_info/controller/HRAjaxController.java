package com.olive.hr_info.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.olive.dto.DeptTest;
import com.olive.dto.Emp;
import com.olive.dto.EmpTest;
import com.olive.hr_info.service.Hr_infoService;
import com.olive.utils.Criteria;
import com.olive.utils.Pagination;
import com.olive.utils.service.PagingService;




@RestController
@RequestMapping("/HRinfo/")
public class HRAjaxController {
	
	@Autowired
	private Hr_infoService empService;

	
	@Autowired
	private PagingService pagingService;
	
	//Emp 
	@RequestMapping(value = "Emp.do", method = RequestMethod.POST)
	public JSONObject getEmpListBykeyword(Criteria cri) {
		
		cri.setCriteria("empinfo", "empno", "asc");
		int totalCount = pagingService.getListCount(cri);
		Pagination pagination = new Pagination(cri, totalCount);
		List<Map<String, Object>> result = pagingService.getList(cri);
		
		cri.setPerPageNum(3);
	    
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("emplist", result);
		jsonObject.put("pagination", pagination);
		jsonObject.put("criteria", cri);
		
		System.out.println("ajax"+result);
		System.out.println("ajax"+pagination);
		System.out.println("ajax"+cri);
		
		return jsonObject;		
	}
	

	//사원 사번 조회 //일단 모달창 전용으로 
	@RequestMapping(value="searchByEmpno.do", method = RequestMethod.POST)
	public Map<String, Object> searchEmpByEmpno(String empno){
		System.out.println(empno);
		Map<String, Object> emp = empService.searchEmpByEmpno(empno);
		System.out.println("얘 뽑은거임"+emp);
		return emp;
	}
	
	//조직도 부서별 조회
	@RequestMapping(value="showOrgbyDept.do")
	public List<DeptTest> showOrgbyDept(String param){
		List<DeptTest> emplist = empService.showOrgbyDept(param);
		return emplist;
	}

//	//마이페이지 수정하기
//	@RequestMapping(value="updateMyInfo.do")
//	public Emp updateMyInfo(String param1, String param2, String param3, String param4, String param5, String param6) {
//		Map<String, String> map = new HashMap<String, String>();
//		map.put("param1", param1); //empno
//		map.put("param2", param2); //pwd
//		map.put("param3", param3); //email
//		map.put("param4", param4); //phone
//		map.put("param5", param5); //address
//		map.put("param6", param6); //profilepic
//		
//		
//		System.out.println(param6);
//		
//		
//		//CommonsMultipartFile multifile =param6.getFile();
//		//String filename  = multifile.getOriginalFilename();
//		
//		
//		System.out.println("여기는 왔어");
//		Emp emp = empService.updateMyInfo(map);
//		System.out.println(emp);
//		return emp;
//	}
	
	
	
}

package kr.co.util;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import kr.co.vo.BoardVO;

@Component("fileUtils")
public class FileUtils {
	private static final String filePath = "C:\\mp\\file\\"; // 파일이 저장될 위치
	
	public List<Map<String, Object>> parseInsertFileInfo(BoardVO boardVO, 
			MultipartHttpServletRequest mpRequest) throws Exception{
		
		/*
			Iterator은 데이터들의 집합체? 에서 컬렉션으로부터 정보를 얻어올 수 있는 인터페이스입니다.
			List나 배열은 순차적으로 데이터의 접근이 가능하지만, Map등의 클래스들은 순차적으로 접근할 수가 없습니다.
			Iterator을 이용하여 Map에 있는 데이터들을 while문을 이용하여 순차적으로 접근합니다.
		*/
		Iterator<String> iterator = mpRequest.getFileNames(); // 요청에서 파일이름 가져오기
		
		MultipartFile multipartFile = null; 
		String originalFileName = null; 		// 원본파일 이름
		String originalFileExtension = null; 	// 원본파일 확장자
		String storedFileName = null;			// 저장 된 파일 이름
		
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>(); // 데이터 담을 리스트 생성
		Map<String, Object> listMap = null; 
		
		int bno = boardVO.getBno(); // 게시글의 bno 가져오기
		
		File file = new File(filePath); // 로컬서버에 저장할 패스를 지정하고 파일 객체 생성
		if(file.exists() == false) {
			file.mkdirs(); // 로컬서버에 패스로 지정된 디렉터리가 없으면 생성해준다.
		}
		
		while(iterator.hasNext()) { // 저장할 첨부파일 개수만큼 반복
			multipartFile = mpRequest.getFile(iterator.next()); // 넘어온 요청에서 파일을 multipartFile 객체에다 담는다.
			if(multipartFile.isEmpty() == false) { // 파일이 비어 있지 않으면
				originalFileName = multipartFile.getOriginalFilename(); // 원본파일 이름 저장
				originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf(".")); // 파일 확장자 저장
				storedFileName = getRandomString() + originalFileExtension; // UUID를 이용하여 서버에 저장될 파일명으로 저장
				
				file = new File(filePath + storedFileName); // 서버패스 + 저장될파일이름으로 껍데기 파일 생성
				multipartFile.transferTo(file); // 껍데기파일에 업로드 된 데이터를 입힌다.
				listMap = new HashMap<String, Object>(); 
				listMap.put("BNO", bno);
				listMap.put("ORG_FILE_NAME", originalFileName);
				listMap.put("STORED_FILE_NAME", storedFileName);
				listMap.put("FILE_SIZE", multipartFile.getSize());
				list.add(listMap); // DB에 저장할 데이터 추가
			}
		}
		return list;
	}
	
	public List<Map<String, Object>> parseUpdateFileInfo(BoardVO boardVO, String[] files, String[] fileNames, MultipartHttpServletRequest mpRequest) throws Exception{ 
		Iterator<String> iterator = mpRequest.getFileNames(); // 요청에서 업로드 된 파일 이름을 iterator에 저장
		MultipartFile multipartFile = null; 
		String originalFileName = null; 
		String originalFileExtension = null; 
		String storedFileName = null; 
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		Map<String, Object> listMap = null; 
		int bno = boardVO.getBno();
		while(iterator.hasNext()){ 
			multipartFile = mpRequest.getFile(iterator.next());  // iterator에 저장된 이름으로 multipartFile 객체 생성
			if(multipartFile.isEmpty() == false){ // multipartFile 객체가 비어있지 않을 경우
				originalFileName = multipartFile.getOriginalFilename(); // 원본 파일명 저장
				originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf(".")); // 확장자 저장
				storedFileName = getRandomString() + originalFileExtension; // UUID를 이용하여 서버에 저장될 파일 고유이름을 확장자와 함께 저장
				multipartFile.transferTo(new File(filePath + storedFileName)); // 업로드 된 파일을 실제 서버에 저장
				listMap = new HashMap<String,Object>(); // HashMap 객체 생성
				listMap.put("IS_NEW", "Y"); 
				listMap.put("BNO", bno); 
				listMap.put("ORG_FILE_NAME", originalFileName);
				listMap.put("STORED_FILE_NAME", storedFileName); 
				listMap.put("FILE_SIZE", multipartFile.getSize()); 
				list.add(listMap); // DB에 저장 될 데이터 추가.
			} 
		}
		if(files != null && fileNames != null){  // 
			for(int i = 0; i<fileNames.length; i++) {
					listMap = new HashMap<String,Object>();
                    listMap.put("IS_NEW", "N");
					listMap.put("FILE_NO", files[i]); 
					list.add(listMap); 
			}
		}
		return list; 
	}
	
	public static String getRandomString() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}
}
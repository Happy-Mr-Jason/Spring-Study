package org.zerock.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.domain.AttachFileDTO;

import lombok.extern.log4j.Log4j2;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j2
public class UploadController {

	@GetMapping("/uploadForm")
	public void uploadForm() {
		log.info("uploadForm.........");
	}

	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile, Model model) {
		String uploadFolder = "C:\\upload";
		log.info("UploadFromAction.. find files........................");
		for (MultipartFile multipartFile : uploadFile) {
			log.info("UploadFormAction..........................");
			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
			log.info("Upload File Size : " + multipartFile.getSize());

			File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());
			try {
				multipartFile.transferTo(saveFile);
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		}
	}

	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		log.info("upload ajax.........");
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "uploadAjaxAction", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		List<AttachFileDTO> list = new ArrayList<>();
		log.info("update ajax post...........");
		String uploadFolder = "C:\\upload";
		String uploadFolderPath = getFolder();

		File uploadPath = new File(uploadFolder, uploadFolderPath);
		log.info("upload path:" + uploadPath);

		if (!uploadPath.exists()) {
			uploadPath.mkdirs();
		}

		for (MultipartFile multipartFile : uploadFile) {
			AttachFileDTO attachDTO = new AttachFileDTO();
			log.info("==================================");
			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
			log.info("Upload File Size : " + multipartFile.getSize());

			String uploadFileName = multipartFile.getOriginalFilename();
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);

			log.info("only file name : " + uploadFileName);

			attachDTO.setFileName(uploadFileName);

			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName;

			try {
				File saveFile = new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile);

				attachDTO.setUuid(uuid.toString());
				attachDTO.setUploadPath(uploadFolderPath);

				if (checkImageType(saveFile)) {
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
					attachDTO.setImage(true);
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
				}

				list.add(attachDTO);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		}
		return new ResponseEntity<>(list, HttpStatus.OK);
	}

	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName) {

		ResponseEntity<byte[]> result = null;

		log.info("fileName : " + fileName);

		File file = new File("c:\\upload\\" + fileName);

		log.info("file : " + file);

		try {
			HttpHeaders headers = new HttpHeaders();
			log.info("file.toPath : " + file.toPath());
			log.info("file Content-Type : " + Files.probeContentType(file.toPath()));
			headers.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), headers, HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}

	@GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName) {

		log.info("download file : " + fileName);

		Resource resource = new FileSystemResource("c:\\upload\\" + fileName);

		log.info("resource : " + resource);

		if (!resource.exists()) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}

		String resourceName = resource.getFilename();

		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_") + 1);

		HttpHeaders headers = new HttpHeaders();

		try {

			String downloadName = null;
			if (userAgent.contains("Trident")) {
				log.info("IE browser");
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8").replaceAll("\\+", " ");
			} else if (userAgent.contains("Edge")) {
				log.info("Edge browser");
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8");
				log.info("Edge name : " + downloadName);
			} else {
				log.info("Chrome browser");
				downloadName = new String(resourceOriginalName.getBytes("UTF-8"), "ISO-8859-1");
			}

			log.info("downloadName : " + downloadName);

			headers.add("Content-Disposition", "attachment; filename=" + downloadName);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		return new ResponseEntity<>(resource, headers, HttpStatus.OK);
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type) {

		log.info("deleteFile : " + fileName);
		log.info("type : " + type);

		File file;

		try {
			file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));
			file.delete();
			if (type.equals("image")) {
				String largeFileName = file.getAbsolutePath().replace("s_", "");
				log.info("largeFileName: " + largeFileName);
				file = new File(largeFileName);
				file.delete();
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}

	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
	}

	private boolean checkImageType(File file) {

		try {
			String contentType = Files.probeContentType(file.toPath());
			log.info("probeContentType : " + contentType);
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}

		return false;
	}
}

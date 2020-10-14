package co.salpa.bookery.find.controller;

import static org.junit.Assert.*;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.awt.image.ImageFilter;
import java.awt.image.RGBImageFilter;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.util.Base64;

import javax.imageio.ImageIO;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(value = "classpath:/applicationContext.xml")
public class FindAddControllerTest {

	
	@Autowired
	SqlSession sqlSession;

	
	public String resizeImageFile(String path, String savedName) throws Exception {
		 
	//	path = "C:\\Users\\jhj71\\Desktop\\eGovFrameDev-3.9.0-64bit\\sts-bundle\\sts-3.9.13.RELEASE\\stsworkspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\bookery\\resources\\cover";
	//	savedName = "ca4afc9b-23b6-4f69-8ed6-f41bb5cdcd31bell-icon.png";
		 
	
		
		Image originalImage = ImageIO.read(new File(path,savedName));

		  int originWidth = originalImage.getWidth(null);
		  int originHeight = originalImage.getHeight(null);

		  int newWidth = 140;

//		  if (originWidth > newWidth) {
		if (originWidth > 100) {
			 System.out.println("reSize");
		    int newHeight = (originHeight * newWidth) / originWidth;

			Image resizeImage = originalImage.getScaledInstance(newWidth, newHeight, Image.SCALE_SMOOTH);

		    BufferedImage newImage = new BufferedImage(newWidth, newHeight, BufferedImage.TYPE_INT_ARGB);
		    Graphics graphics = newImage.getGraphics();
		    graphics.drawImage(resizeImage, 0, 0, null);
			graphics.dispose();

			String resizeImgName = savedName;
			File newFile = new File(path + File.separator + resizeImgName);
		    String formatName = savedName.substring(savedName.lastIndexOf(".") + 1);
		    ImageIO.write(newImage, formatName.toLowerCase(), newFile);
		    
			//transparency(path + File.separator + formatName.toLowerCase());
		    
		    return resizeImgName;    
		  } else {
			return savedName;
		  }
		}
	

	@Test
	public void testCoverImgUpload() {
		String path = "C:\\Users\\jhj71\\Desktop\\eGovFrameDev-3.9.0-64bit\\sts-bundle\\sts-3.9.13.RELEASE\\stsworkspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\bookery\\resources\\cover";
		//String savedName = "ca4afc9b-23b6-4f69-8ed6-f41bb5cdcd31bell-icon.png";
		String savedName = "bookspng.png";
		try {
			resizeImageFile(path,savedName);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}

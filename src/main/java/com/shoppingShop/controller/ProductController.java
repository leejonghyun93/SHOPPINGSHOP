package com.shoppingShop.controller;

import com.shoppingShop.domain.InquiryDto;
import com.shoppingShop.domain.ProductDto;
import com.shoppingShop.service.CartService;
import com.shoppingShop.service.InquiryService;
import com.shoppingShop.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller // 이 클래스가 Spring MVC의 컨트롤러임을 나타냅니다.
@RequestMapping("/product") // 이 컨트롤러의 기본 요청 경로를 "/product"로 설정합니다.
public class ProductController {

    @Autowired // Spring이 자동으로 해당 타입의 빈을 주입하도록 합니다.
    private ProductService productService;

    @Autowired
    private CartService cartService;

    @Autowired
    private InquiryService inquiryService;

    // 인텔리제이에서 사용할 수 있는 이미지 베이스 경로
    private static final String IMAGE_BASE_PATH = "/resources/img/products/";

    @GetMapping("/detail/{proId}") // HTTP GET 요청이 "/detail/{proId}"로 올 때 이 메서드가 호출됩니다.
    public String productDetail(@PathVariable int proId, Model model,
                                @RequestParam(value = "page", defaultValue = "1") int page,
                                @RequestParam(value = "size", defaultValue = "5") int size) throws Exception {

        // 상품 상세 정보 가져오기
        ProductDto detail = productService.getProductDetail(proId);

        // 모델에 product 객체 추가
        model.addAttribute("product", detail);  // product 객체를 JSP에서 사용 가능하게 만듦

        // 이미지 디렉토리 설정
        String productImagePath = IMAGE_BASE_PATH + proId;
        File folder = Paths.get(productImagePath).toFile();

        List<String> imagePaths = new ArrayList<>();

        if (folder.exists() && folder.isDirectory()) {
            for (File file : folder.listFiles()) {
                if (file.isFile() && (file.getName().toLowerCase().endsWith(".jpg") || file.getName().toLowerCase().endsWith(".jpeg") || file.getName().toLowerCase().endsWith(".png"))) {
                    imagePaths.add("/img/products/" + proId + "/" + file.getName());
                }
            }
        }

        // 이미지가 없을 경우 기본 이미지 추가
        if (imagePaths.isEmpty()) {
            imagePaths.add("/img/no-image.jpg");
        }

        // 모델에 데이터 추가
        model.addAttribute("productDetail", detail);
        model.addAttribute("imagePaths", imagePaths);
        model.addAttribute("inquiries", inquiryService.getInquiriesByProductId(proId, page, size));
        model.addAttribute("totalPages", inquiryService.getTotalPagesByProductId(proId, size));
        model.addAttribute("currentPage", page);

        return "product/productDetail"; // "product/productDetail" 뷰를 반환합니다.
    }

    @GetMapping("/current") // HTTP GET 요청이 "/current"로 올 때 이 메서드가 호출됩니다.
    public ResponseEntity<ProductDto> getCurrentProduct(@RequestParam("proId") int proId) {
        ProductDto product = productService.getCurrentProduct(proId);
        if (product == null) {
            return ResponseEntity.notFound().build();  // 404 응답을 반환합니다.
        }
        return ResponseEntity.ok(product);  // 정상적으로 상품 정보를 반환합니다.
    }

    @PostMapping("/inquiry/write") // HTTP POST 요청이 "/inquiry/write"로 올 때 이 메서드가 호출됩니다.
    @ResponseBody // 이 메서드의 반환값이 HTTP 응답 본문으로 직접 작성됨을 나타냅니다.
    public ResponseEntity<Map<String, Object>> writeInquiry(
            @RequestParam("proId") int proId,
            @RequestBody InquiryDto inquiryDto,
            HttpSession session) {

        Map<String, Object> response = new HashMap<>();

        try {
            // 디버깅: proId 확인
            System.out.println("Received proId: " + proId);
            System.out.println("Received InquiryDto: " + inquiryDto);

            // 세션에서 userId 가져오기
            String userId = (String) session.getAttribute("userId");
            if (userId == null || userId.isEmpty()) {
                response.put("success", false);
                response.put("message", "로그인이 필요합니다.");
                return ResponseEntity.status(401).body(response);
            }

            // userId와 proId 설정
            inquiryDto.setUserId(userId);
            inquiryDto.setProId(proId);

            // Inquiry 저장
            inquiryService.addInquiry(inquiryDto);

            response.put("success", true);
            response.put("inquiryId", inquiryDto.getInquiryId());

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "문의 등록 중 오류가 발생했습니다.");
            return ResponseEntity.status(500).body(response);
        }
    }

    @GetMapping("/inquiry/detail/{inquiryId}") // HTTP GET 요청이 "/inquiry/detail/{inquiryId}"로 올 때 이 메서드가 호출됩니다.
    @ResponseBody // 이 메서드의 반환값이 HTTP 응답 본문으로 직접 작성됨을 나타냅니다.
    public Map<String, Object> getInquiryDetail(@PathVariable("inquiryId") int inquiryId) {
        System.out.println("Received inquiryId: " + inquiryId); // 디버깅용 출력
        Map<String, Object> response = new HashMap<>();

        try {
            InquiryDto inquiry = inquiryService.getInquiryDetail(inquiryId);
            response.put("success", true);
            response.put("inquiry", inquiry);
        } catch (Exception e) {
            response.put("success", false);
            response.put("error", e.getMessage());
        }

        return response;
    }
}

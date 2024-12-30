package com.shoppingShop.controller;

import com.shoppingShop.domain.ProductDto;
import com.shoppingShop.service.CartService;
import com.shoppingShop.service.InquiryService;
import com.shoppingShop.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.File;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/product")
public class ProductController {

    @Autowired
    private ProductService productService;

    @Autowired
    private CartService cartService;

    @Autowired
    private InquiryService inquiryService;

    // 인텔리제이에서 사용할 수 있는 이미지 베이스 경로
    private static final String IMAGE_BASE_PATH = "/resources/img/products/";

    @GetMapping("/detail/{proId}")
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
                if (file.isFile() && (file.getName().toLowerCase().endsWith(".JPG") || file.getName().toLowerCase().endsWith(".jpeg") || file.getName().toLowerCase().endsWith(".png"))) {
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
        model.addAttribute("inquiries", inquiryService.getInquiriesByPage(page, size));
        model.addAttribute("totalPages", inquiryService.getTotalPages(size));
        model.addAttribute("currentPage", page);

        return "product/productDetail";
    }


    @GetMapping("/current")
    public ResponseEntity<ProductDto> getCurrentProduct(@RequestParam("proId") int proId) {
        ProductDto product = productService.getCurrentProduct(proId);
        if (product == null) {
            return ResponseEntity.notFound().build();  // 404 응답으로 변경
        }
        return ResponseEntity.ok(product);  // 정상적으로 상품 정보를 반환
    }
}
package com.shoppingShop.interceptor;

import com.shoppingShop.domain.CategoryDto;
import com.shoppingShop.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class CategoryInterceptor implements HandlerInterceptor {

    @Autowired
    private CategoryService categoryService;

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        if (modelAndView != null) {
            List<CategoryDto> mainCategories = categoryService.getMainCategories();
            modelAndView.addObject("mainCategories", mainCategories);
        }
    }
}
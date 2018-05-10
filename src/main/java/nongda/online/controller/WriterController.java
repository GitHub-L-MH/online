package nongda.online.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("writer")
public class WriterController {

    @RequestMapping("index")
    public String index(Model model){
        return "online/writer/index";
    }
}

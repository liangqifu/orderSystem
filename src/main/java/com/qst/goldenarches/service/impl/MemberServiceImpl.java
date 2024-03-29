/**
 * FileName: MemberServiceImpl
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/10/4 13:34
 * Description:
 */
package com.qst.goldenarches.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qst.goldenarches.dao.MemberMapper;
import com.qst.goldenarches.dao.OrderMapper;
import com.qst.goldenarches.pojo.VIP;
import com.qst.goldenarches.service.MemberService;

@Service
public class MemberServiceImpl implements MemberService {
    @Autowired
    private MemberMapper memberMapper;

    @Autowired
    private OrderMapper orderMapper;

    public List<VIP> getAll(Map<String, String> map) {
        return memberMapper.selectAll(map);
    }

    public void editMemberBalance(VIP vip) {
        memberMapper.updateMemberBalance(vip);
    }

    public boolean removeMember(Integer id) {
        int count =orderMapper.countBuyerById(id);
        System.out.println(count);
        if(0==count){
            memberMapper.deleteById(id);
            return true;
        }
        return false;
    }
}

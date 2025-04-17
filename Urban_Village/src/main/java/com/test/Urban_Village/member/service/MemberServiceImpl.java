package com.test.Urban_Village.member.service;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.Urban_Village.member.dao.MemberDAO;
import com.test.Urban_Village.member.dao.MemberDAOImpl;
import com.test.Urban_Village.member.dto.MemberDTO;
import com.test.Urban_Village.member.dto.PayDTO;

@Service
public class MemberServiceImpl implements MemberService {
		@Autowired
		MemberDAO dao;
		
		@Override
		public List<MemberDTO> listMembers() {
			// TODO Auto-generated method stub
			return dao.listMembers();
		}

		@Override
		public MemberDTO login(String id, String pwd) {
		    MemberDTO member = new MemberDTO();
		    member.setId(id);
		    member.setPwd(pwd);
		    return dao.login(member); // DB���� �ش� ������ ��ȸ
		}

		@Override
	      public int addMember(MemberDTO member) {
	         // TODO Auto-generated method stub
	         return dao.addMember(member);
	      }
		
		@Override
	      public List<MemberDTO> getUserInfoById(String id) {
	         // TODO Auto-generated method stub
	         return dao.getUserInfoById(id);
	      }
		
		@Override
	      public int updateUserInfo(MemberDTO member) {
	         // TODO Auto-generated method stub
	         return dao.updateUserInfo(member);
	      }
		
		@Override
	       public boolean checkIfUserIdExists(String userId) {
	           return dao.checkIfUserIdExists(userId);
	       }


		@Override
		public void addPay(PayDTO payDto) {
			// TODO Auto-generated method stub
			dao.addPay(payDto);
			
		}

		@Override
		public List<PayDTO> payList() {
			// TODO Auto-generated method stub
			return dao.payList();
		}

		@Override
		public List<PayDTO> reservationGetUserId(String loginId) {
			// TODO Auto-generated method stub
			return dao.reservationGetUserId(loginId);
		}
		
		@Override
		   public int deleteMember(String id) {
		      return dao.deleteMember(id);
		   }
		
		  @Override
		   public List<PayDTO> getDailySales() {
		      List<PayDTO> dailySalesList = dao.getDailySales();
		       System.out.println("일별 매출 데이터 (서비스): " + dailySalesList); // 추가
		       return dao.getDailySales();
		   }

		   @Override
		   public List<PayDTO> getMonthlySales() {
		       return dao.getMonthlySales();
		   }

		   @Override
		   public List<PayDTO> getYearlySales() {
		       return dao.getYearlySales();
		   }

		@Override
		public int findPwdForId(String member_id) {
			// TODO Auto-generated method stub
			return dao.findPwdForId(member_id);
		}
		@Override
	      public List<MemberDTO> searchMembersById(String id) {
	            return dao.searchMembersById(id);
	      }

		@Override
		public String findEmailById(String member_id) {
			// TODO Auto-generated method stub
			return dao.findEmailById(member_id);
		}
}

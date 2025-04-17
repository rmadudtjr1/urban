package com.test.Urban_Village.reservation.dao;

import java.sql.Date;
import java.util.List;

import javax.naming.spi.DirStateFactory.Result;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.Urban_Village.member.dto.MemberDTO;
import com.test.Urban_Village.member.dto.PayDTO;

@Repository
public class ReservationDAOImpl implements ReservationDAO {

	@Autowired
	SqlSession sqlSession;

	@Override
	public void addPay(PayDTO payDto) {
		// TODO Auto-generated method stub
		sqlSession.insert("mapper.member.addPay", payDto);
	}

	@Override
	public List<PayDTO> payList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.member.payList") ;
	}

	@Override
	public List<PayDTO> reservationGetUserId(String loginId) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.member.reservationGetUserId", loginId);
	}

	@Override
	   public int delReservation(String reservation_id) {
	      // TODO Auto-generated method stub
	      return sqlSession.delete("mapper.reservation.delReservation", reservation_id);
	   }
}

package nongda.online.domain;

import java.util.Date;

public class User {

	private Long id;//id
	private String userName;//用户名
	private String passWord;//密码
	private Long createBy;//创建者
	private Date createTime;//创建时间
	private Long editBy;//修改者
	private Date editTime;//修改时间
	private int flag;//权限1代表编辑2专家3作者
	public int getFlag() {
		return flag;
	}
	public void setFlag(int flag) {
		this.flag = flag;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassWord() {
		return passWord;
	}
	public void setPassWord(String passWord) {
		this.passWord = passWord;
	}
	public Long getCreateBy() {
		return createBy;
	}
	public void setCreateBy(Long createBy) {
		this.createBy = createBy;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Long getEditBy() {
		return editBy;
	}
	public void setEditBy(Long editBy) {
		this.editBy = editBy;
	}
	public Date getEditTime() {
		return editTime;
	}
	public void setEditTime(Date editTime) {
		this.editTime = editTime;
	}
	
	
}

class CreateSueforms < ActiveRecord::Migration
  def change
    create_table :sueforms do |t|
      t.boolean :evidence #증거 제출 여부
      t.string :law_kind # 법 종류 모욕죄/사기/협박
      t.boolean :sue_sort # 진정/고소 확인
      t.string :location # 명예훼손 및 모욕죄 분야
      t.string :account_number # forgery 부분 계좌번호
      t.string :birth_year #생년월일
      t.string :birth_month
      t.string :birth_day
      t.text :sig_src # 고소인 서명
      t.string :police_name #관할서
      t.integer :user_id # 작성자 id
      t.string :my_phone # 고소인 연락처
      t.string :my_name # 고소인 이름
      t.string :my_game_name #고소인 닉네임
      t.string :address1 #주소
      t.string :address2 #주소 
      t.string :post_code # 우편번호
      t.string :you_id # 피고소인 id
      t.string :you_phone #피고소인 연락처
      t.string :you_address #피고소인 우편번호
      t.string :you_address1 #주소
      t.string :you_address2 #주소
      t.string :you_url # 사건 발생 url
      t.text :sue_reason #고소 이유
      t.text :sue_content #고소 내용
      t.timestamps null: false
    end
  end
end

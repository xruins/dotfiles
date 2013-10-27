(require 'metaweblog)
(require 'org2blog-autoloads)
(setq org2blog/wp-blog-alist 
       '(("wordpress" 
          :url "http://www.rcc.ritsumei.ac.jp/fes/xmlrpc.php"  ;; ;xmlrcp.phpのURL
          :username "ruins"  
;;         :password "password" 
          :default-title "Hello World" ;; ; デフォルトタイトル
          :default-categories ("daily") ;; ;カテゴリを指定 
          :tags-as-categories nil))) ;; ; タグを指定

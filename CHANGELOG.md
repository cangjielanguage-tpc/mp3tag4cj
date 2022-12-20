## 0.0.1
- 读取、写入、添加和删除ID3v1标签。
- 适配cjc 0.31.4
- 适配cjc 0.32.5
## 0.0.2
- 读取、写入、添加和删除ID3v2标签，customTag标签。
- 获取和修改ID3v2标签部分标识对应的数据。
- 获取音频数据帧帧头相关数据。
- 适配cjc 0.32.5
- 适配cjc 0.33.3
## 0.0.3
- 添加ID3v2标签urlFrame，wwwFrame,commentFrame类型
## 0.0.4
- 適配cjc 0.34.3
- 添加ID3v2标签API
- getComment (): Option<String>
- setComment (comment: Option<String>): Unit
- getItunesComment (): Option<String>
- setItunesComment (itunesComment: Option<String>): Unit
- getLyrics (): Option<String>
- setLyrics (lyrics: Option<String>): Unit
- getArtistUrl (): Option<String>
- setArtistUrl (url: Option<String>): Unit
- getCommercialUrl (): Option<String>
- setCommercialUrl (url: Option<String>): Unit
- getCopyrightUrl (): Option<String>
- setCopyrightUrl (url: Option<String>): Unit
- getAudiofileUrl (): Option<String>
- setAudiofileUrl (url: Option<String>): Unit
- getAudioSourceUrl (): Option<String>
- setAudioSourceUrl (url: Option<String>): Unit
- getRadiostationUrl (): Option<String>
- setRadiostationUrl (url: Option<String>): Unit
- getPaymentUrl (): Option<String>
- setPaymentUrl (url: Option<String>): Unit
- getPublisherUrl (): Option<String>
- setPublisherUrl (url: Option<String>): Unit
- getUrl (): Option<String>
- setUrl (url: Option<String>): Unit
- clearFrameSet (id: String): Unit
## 0.0.5
- 添加图片的设置、获取方法
- 適配cjc 0.35.6
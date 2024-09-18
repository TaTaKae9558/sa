# Satori 

## Adım 1: Contabo'dan VPS Siparişi Verin

Aşağıdaki sayfayı ziyaret ederek VPS siparişinizi verin ve işletim sistemi olarak Ubuntu 22.04'ü seçin:

[Contabo VPS](https://contabo.com/en/vps/cloud-vps-1/?image=ubuntu.323&qty=1&contract=1&storage-type=vps-1-400-gb)

E-posta ile bilgilendirileceksiniz.

## Adım 2: MobaXTerm İndirin ve SSH Bağlantısı Kurun (PC)

MobaXTerm'i indirin ve kurun (Windows) (ya da başka bir SSH aracı kullanabilirsiniz).

İndirme bağlantısı: [MobaXTerm İndirme](https://mobaxterm.mobatek.net/download-home-edition.html)

MobaXTerm'i başlatın ve VPS'nize yeni bir SSH bağlantısı oluşturun.

(Giriş yaptıktan sonra, root şifrenizi girmeniz gerekecek. Şifreyi girerken hiçbir şey görünmeyecek, sadece yazın ve enter tuşuna basın.)

## Adım 3: Kurulum Scriptini İndirin ve Çalıştırın

Aşağıdaki komutu kopyalayın ve yapıştırın:

```bash
wget https://raw.githubusercontent.com/TaTaKae9558/sa/refs/heads/main/setup.sh -O setup.sh && chmod +x setup.sh && sudo ./setup.sh
```
Kurulum tamamlandıktan sonra :

### Satori Node'yi config / kontrol edin: bir tarayıcıya gidin, “http://<IP adresiniz>:26401” girin

  1. Vault'ta girin, bir parola ile güvenceye alın => Güçlü Parola Oluşturun ve unutmayin.
  2. Şifreyi yapılandırdıktan sonra, Satori kilitlemek için sağ üst köşedeki kilit simgesine tıklayın.

#### Artık Satori'ye erişmek istediğinizde, vault şifrenizi girmeniz gerekecek

## Adım 4: Local (PC'de) Satori node kur

[Virtual Machine kurmak](https://github.com/TaTaKae9558/sa/blob/main/local/README.md)


## Adım 5: Güvenli aktif et

Güvenli seçeneği etkinleştirmek, tarayıcı GUI erişimini devre dışı bırakır ve güvenliği artırır.

Aşağıdaki komutu kopyalayın ve yapıştırın:

```bash
echo "headless: true" >> ~/.satori/config/config.yaml
```

Güvenli seçeneği devre dışı bırakmak ve tarayıcı GUI erişimini geri yüklemek için aşağıdaki komutu çalıştırın:

```bash
sed -i '/headless: true/d' ~/.satori/config/config.yaml
```
Güvenli seçeneği etkinleştirip/devre dışı bıraktıktan sonra, Satori Node'u yeniden başlatmak için aşağıdaki komutu kullanin:

```bash
sudo docker stop satorineuron
```

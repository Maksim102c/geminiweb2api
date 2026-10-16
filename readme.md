# 🍌 GeminiWeb2API

> **Версия:** 1.4  
> **Автор:** [@roflenskoy](https://t.me/roflenskoy) (Telegram)  
> **Репозиторий:** [github.com/l4ckofsleep/geminiweb2api](https://github.com/l4ckofsleep/geminiweb2api)

Неофициальный API-прокси, превращающий веб-версию **Google Gemini** в локальный сервер с OpenAI-совместимым и Gemini-совместимым API. Работает с **SillyTavern** (текст), **SillyImages** (картинки) и любыми другими клиентами.

---

## 📑 Оглавление

- [⚠️ Дисклеймер](#%EF%B8%8F-%D0%B4%D0%B8%D1%81%D0%BA%D0%BB%D0%B5%D0%B9%D0%BC%D0%B5%D1%80)
- [✨ Возможности](#-%D0%B2%D0%BE%D0%B7%D0%BC%D0%BE%D0%B6%D0%BD%D0%BE%D1%81%D1%82%D0%B8)
- [🤖 Модели](#-%D0%BC%D0%BE%D0%B4%D0%B5%D0%BB%D0%B8)
- [🚀 Быстрый старт](#-%D0%B1%D1%8B%D1%81%D1%82%D1%80%D1%8B%D0%B9-%D1%81%D1%82%D0%B0%D1%80%D1%82)
- [💻 Установка](#-%D1%83%D1%81%D1%82%D0%B0%D0%BD%D0%BE%D0%B2%D0%BA%D0%B0)
  - [Windows / macOS](#windows--macos)
  - [Linux Desktop](#linux-desktop)
  - [Android (Termux)](#android-termux)
- [🔗 Подключение](#-%D0%BF%D0%BE%D0%B4%D0%BA%D0%BB%D1%8E%D1%87%D0%B5%D0%BD%D0%B8%D0%B5)
  - [SillyTavern (текст)](#sillytavern-%D1%82%D0%B5%D0%BA%D1%81%D1%82)
  - [SillyImages (картинки)](#sillyimages-%D0%BA%D0%B0%D1%80%D1%82%D0%B8%D0%BD%D0%BA%D0%B8)
- [🚩 Флаги запуска](#-%D1%84%D0%BB%D0%B0%D0%B3%D0%B8-%D0%B7%D0%B0%D0%BF%D1%83%D1%81%D0%BA%D0%B0)
- [🛡️ Прокси](#%EF%B8%8F-%D0%BF%D1%80%D0%BE%D0%BA%D1%81%D0%B8)
- [🔄 Решение проблем](#-%D1%80%D0%B5%D1%88%D0%B5%D0%BD%D0%B8%D0%B5-%D0%BF%D1%80%D0%BE%D0%B1%D0%BB%D0%B5%D0%BC)
- [📞 Связь](#-%D1%81%D0%B2%D1%8F%D0%B7%D1%8C)
- [English version below](#english-version)

---

## ⚠️ Дисклеймер

Проект создан **исключительно в образовательных целях**. Он использует реверс-инжиниринг внутренних API Google, что является нарушением ToS Google.

- **Используйте отдельный (твинк) Google-аккаунт**, а не основной.
- Разработчик не несёт ответственности за возможные блокировки.
- Риск бана за ботоводство всегда существует.

---

## ✨ Возможности

| Фича | Описание |
|------|----------|
| 📝 **Текст + Картинки** | Универсальный бэкенд для ролевых игр и генерации иллюстраций. |
| 🔓 **Обход цензуры (текст)** | История чата упаковывается в `chat.json` и выгружается как документ — пробивает базовые NSFW-фильтры. |
| 🧠 **Thinking / Extended** | Нативная поддержка моделей с открытым рассуждением. Корректная обработка `<thinking>` и префиллов. |
| 🖼️ **Image2Image** | Отправляйте референсы вместе с промптом — скрипт загрузит их на Google как референсы. |
| 🔑 **Умная авторизация** | Playwright (Win/Mac) или ручные куки (Linux/Android/Termux). |
| 🔄 **Auto-refresh** | Фоновое обновление токена каждые 4–8 минут. |
| 📊 **Логи** | Дневные + per-request логи в `logs/`, маскировка sensitive-данных. |

---

## 🤖 Модели

API автоматически отправляет скрытые сигналы переключения моделей.

### Доступные модели

| ID | Описание | Подписка |
|----|----------|:---:|
| `gemini-4-argon` | Флагманская модель для сложнейших задач. | Да (Pro) |
| `gemini-4-argon-extended` | 4 Argon с глубоким рассуждением (Thinking Level: High/Deep). | Да (Pro) |
| `gemini-4-argon-medium` | 4 Argon с умеренным рассуждением (Thinking Level: Medium). | Да (Pro) |
| `gemini-3.8-flash` | Актуальная базовая быстрая модель Gemini Web. | Нет |
| `gemini-3.8-flash-extended` | 3.8 Flash с расширенным рассуждением. | Нет |
| `gemini-3.5-flash-lite` | Ультра-быстрые краткие ответы. | Нет |
| `gemini-3.1-pro-preview` | Тяжёлая интеллектуальная модель. | Да (Pro) |
| `gemini-3.1-pro-extended` | 3.1 Pro с расширенным рассуждением. | Да (Pro) |
| `nano-banana-2` | Генерация картинок (базовая бесплатная). | Нет |
| `nano-banana-pro` | Продвинутая модель для картинок. | Да (Pro) |

### Режимы рассуждения (Thinking / Думалка)

В Gemini Web доступно 3 уровня рассуждений, выбираемых суффиксом в названии модели:
- **Уровень 1 (Низкая / Standard):** базовое имя (`gemini-4-argon`, `gemini-3.8-flash`) или суффикс `-standard` / `-low`.
- **Уровень 2 (Средний / Medium):** суффикс `-medium` / `-moderate` (например, `gemini-4-argon-medium`).
- **Уровень 3 (Высокая / Extended):** суффикс `-extended` / `-deep` / `-high` / `-thinking` (например, `gemini-4-argon-extended`).

### Alias-имена (синонимы)

**При подключении через `/v1/chat/completions` (OpenAI-совместимый):**
- Любые имена, содержащие `argon` (включая опечатки вроде `argonn`, `gemini-4-argon`) → направляются на **Gemini 4 Argon**.
- `gemini-3.8-flash` / `gemini-3.5-flash` / `gemini-3-flash` → `gemini-3.8-flash`.
- `gemini-3.5-flash-lite` / `flash-lite` → `gemini-3.5-flash-lite`.
- `gemini-3.1-pro` / `gemini-3-pro` → `gemini-3.1-pro-preview`.
- Добавление `thinking`, `extended`, `deep` или `high` автоматически активирует максимальный уровень Thinking (Level 3).
- Добавление `medium` активирует промежуточный уровень Thinking (Level 2).

**При подключении через `/v1beta/models/...` (Gemini API):**
- **ВСЕ** Argon-модели → `gemini-4-argon-extended`
- **ВСЕ** Pro-модели → `gemini-3.1-pro-extended`
- **ВСЕ** Flash-модели → `gemini-3.8-flash-extended`

> *Без подписки Pro-модели и Argon Google может тихо перенаправить на бесплатную Flash.*

---

## 🚀 Быстрый старт

```bash
# 1. Клонировать
git clone https://github.com/l4ckofsleep/geminiweb2api
cd geminiweb2api

# 2. Зависимости
pip install -r requirements.txt
playwright install chromium

# 3. Запуск
python start.py
```

Сервер поднимется на `http://127.0.0.1:1717`.

---

## 💻 Установка

> ⚠️ **Перед установкой убедитесь, что открывается `gemini.google.com` и чат на нём.** Если нет — ищите VPN/прокси.

### Windows / macOS

```bash
pip install -r requirements.txt
playwright install chromium
python start.py
```

При первом запуске:
1. Откроется Chromium → авторизуйтесь в Google.
2. Дождитесь загрузки Gemini.
3. Нажмите **ENTER** в консоли.
4. Сессия сохранится, сервер запустится на порту `1717`.

Если сессия уже была сохранена, `--refresh` сначала попробует тихо обновить куки в headless-режиме.

### Linux Desktop

Google может блокировать Playwright как небезопасный браузер, поэтому Linux использует **ручной cookie-flow**:

```bash
git clone https://github.com/l4ckofsleep/geminiweb2api
cd geminiweb2api
pip install -r requirements.txt
python start.py
```

При первом запуске скрипт попросит два кука:
- `__Secure-1PSID`
- `SAPISID`

**Как достать:**
1. Откройте обычный браузер, зайдите на `gemini.google.com`.
2. Установите расширение **Cookie-Editor**.
3. Скопируйте значения куков и вставьте в консоль по запросу.

> 💡 Если какого-то кука нет — отправьте в Gemini любое сообщение и проверьте снова.

### Android (Termux)

```bash
pkg update && pkg upgrade
pkg install git python rust binutils
export ANDROID_API_LEVEL=24
pip install fastapi uvicorn httpx "httpx[socks]"

cd
git clone https://github.com/l4ckofsleep/geminiweb2api
cd geminiweb2api
python start.py
```

При первом запуске:
1. Установите **Kiwi Browser** или **Firefox**.
2. Поставьте расширение **Cookie-Editor**.
3. Зайдите на `gemini.google.com` (включите **Desktop mode**).
4. Скопируйте куки по запросу консоли.

---

## 🔗 Подключение

### SillyTavern (текст)

1. **API** → `Chat Completion`
2. **Источник** → `Custom (OpenAI-compatible)`
3. **Base URL** → `http://127.0.0.1:1717/v1`
4. **API Key** → любой (например, `banana`)
5. **Модель** → выберите из списка выше

#### Поиск в Интернете

Для включения поиска подключайтесь через **Google AI Studio**:
- **API:** `Chat Completion`
- **Источник:** `Google AI Studio`
- **Прокси:** `http://127.0.0.1:1717`
- **Пароль:** любой
- В первой вкладке настроек включите **`Включить поиск в Интернете`**

### SillyImages (картинки)

1. Выберите источник **Gemini-совместимый (nano-banana)**.
2. **Base URL** → `http://127.0.0.1:1717`
3. **API Key** → любой
4. **Модель** → `nano-banana-pro` (с подпиской) или `nano-banana-2` (бесплатно)

---

## 🚩 Флаги запуска

| Флаг | Описание | Пример |
|------|----------|--------|
| `--temp` | Временный чат (не сохраняется в истории Google) | `python start.py --temp` |
| `--proxy <url>` | Прокси (http/socks4/socks5) | `python start.py --proxy socks5://127.0.0.1:1080` |
| `--port <число>` | Смена порта | `python start.py --port 8080` |
| `--debug` | Подробное логирование + raw ответы | `python start.py --debug` |
| `--mobile` | Принудительно ручной cookie-flow | `python start.py --mobile` |
| `--refresh` | Мягкое обновление сессии | `python start.py --refresh` |
| `--reauth` | Жёсткий сброс (Factory Reset) | `python start.py --reauth` |

---

## 🛡️ Прокси

Если Gemini заблокирован в вашем регионе:

```bash
python start.py --proxy socks5://127.0.0.1:1080
```

> 🚨 **КРИТИЧЕСКОЕ ПРАВИЛО: совпадение IP**
>
> IP, с которого вы авторизовались в браузере, **ДОЛЖЕН СОВПАДАТЬ** с IP скрипта.
> - ❌ **Нельзя:** зайти через VPN Нидерландов, а скрипт запустить без прокси.
> - ✅ **Нужно:** настроить тот же прокси в браузере, авторизоваться, потом запустить скрипт с тем же прокси.

### Где брать прокси

- **Бесплатные** (только для теста): [proxyscrape.com](https://proxyscrape.com), [free-proxy-list.net](https://free-proxy-list.net)
- **Платные** (для постоянной работы): Proxy6, ProxyLine, Smartproxy, Oxylabs

### Как настроить в браузере

- **ПК:** FoxyProxy / ZeroOmega расширение.
- **Android:** Firefox + FoxyProxy, или VPN с split tunneling.

---

## 🔄 Решение проблем

| Симптом | Решение |
|---------|---------|
| Пустой ответ / дефолтная думалка | Проверьте [age-verification](https://myaccount.google.com/age-verification) и настройки думалки. |
| Вместо картинки — референс | Цензура Google. С картинками такое бывает. |
| `502` до получения токена | Проблема на стороне Google. Откройте Gemini в инкогнито — если там тоже `502`, просто подождите. |
| Сессия сбросилась | `python start.py --refresh` (Win/Mac) или `--reauth` для полного сброса. |
| VPS не работает | Google банит IP крупных хостингов. Используйте домашний IP + прокси. |

Логи находятся в папке `logs/`:
- Дневные логи по компонентам (`api-YYYY-MM-DD.log`)
- Per-request логи
- Токены и куки маскируются

---

## 📞 Связь

Возникли проблемы, нашли баг или есть идеи?

**Telegram:** [@roflenskoy](https://t.me/roflenskoy)

---

# English Version

---

## 📑 Table of Contents

- [⚠️ Disclaimer](#%EF%B8%8F-disclaimer)
- [✨ Features](#-features)
- [🤖 Models](#-models)
- [🚀 Quick Start](#-quick-start)
- [💻 Installation](#-installation)
  - [Windows / macOS](#windows--macos-1)
  - [Linux Desktop](#linux-desktop-1)
  - [Android (Termux)](#android-termux-1)
- [🔗 Connection](#-connection)
  - [SillyTavern (text)](#sillytavern-text)
  - [SillyImages (images)](#sillyimages-images)
- [🚩 Launch Flags](#-launch-flags)
- [🛡️ Proxy](#%EF%B8%8F-proxy)
- [🔄 Troubleshooting](#-troubleshooting)
- [📞 Contact](#-contact)

---

## ⚠️ Disclaimer

This project is **for educational purposes only**. It uses reverse engineering of Google's internal Gemini web APIs, which violates Google's Terms of Service.

- **Use a separate (throwaway) Google account**, not your main one.
- The developer is not responsible for any bans or restrictions.
- Risk of account suspension for bot-like activity always exists.

---

## ✨ Features

| Feature | Description |
|---------|-------------|
| 📝 **Text + Images** | Universal backend for roleplay and image generation. |
| 🔓 **Censorship bypass (text)** | Chat history is packed into `chat.json` and uploaded as a document — bypasses basic NSFW filters. |
| 🧠 **Thinking / Extended** | Native support for reasoning models. Correct handling of `<thinking>` tags and prefills. |
| 🖼️ **Image2Image** | Send reference images with prompts — the script uploads them to Google as references. |
| 🔑 **Smart auth** | Playwright (Win/Mac) or manual cookies (Linux/Android/Termux). |
| 🔄 **Auto-refresh** | Background token refresh every 4–8 minutes. |
| 📊 **Logs** | Daily + per-request logs in `logs/`, sensitive data masking. |

---

## 🤖 Models

The API automatically sends hidden model-switching signals.

### Available Models

| ID | Description | Subscription |
|----|-------------|--------------|
| `gemini-3.5-flash` | Basic, very fast text model. | No |
| `gemini-3.5-flash-extended` | Extended reasoning (Thinking). | No |
| `gemini-3.1-pro-preview` | Heavy, maximally smart model. | Yes (Pro) |
| `gemini-3.1-pro-extended` | Pro with extended reasoning. | Yes (Pro) |
| `nano-banana-2` | Simple free model. | No |
| `nano-banana-pro` | Advanced image generation model. | Yes (Pro) |

### Model Aliases

**When connecting via `/v1/chat/completions` (OpenAI-compatible):**
- `gemini-3.5-flash` → `gemini-3.5-flash` (basic)
- `gemini-3.5-flash-extended` / `gemini-3.5-flash-thinking` → `gemini-3.5-flash-extended`
- `gemini-3.1-pro-preview` → `gemini-3.1-pro-preview` (basic)
- `gemini-3.1-pro-extended` → `gemini-3.1-pro-extended`
- `gemini-3.0-flash-preview` / `gemini-3-flash-preview` / `gemini-3.5-flash-preview` → `gemini-3.5-flash`
- `gemini-3.0-flash-thinking-preview` / `gemini-3-flash-thinking-preview` → `gemini-3.5-flash-extended`
- `gemini-3.0-pro-preview` / `gemini-3-pro-preview` → `gemini-3.1-pro-preview`
- `gemini-3-pro-extended` → `gemini-3.1-pro-extended`

**When connecting via `/v1beta/models/...` (Gemini API):**
- **ALL** Flash models → `gemini-3.5-flash-extended`
- **ALL** Pro models → `gemini-3.1-pro-extended`

> *Without a subscription, Google may silently redirect Pro models to the free Flash version.*

---

## 🚀 Quick Start

```bash
# 1. Clone
git clone https://github.com/l4ckofsleep/geminiweb2api
cd geminiweb2api

# 2. Dependencies
pip install -r requirements.txt
playwright install chromium

# 3. Launch
python start.py
```

Server will start at `http://127.0.0.1:1717`.

---

## 💻 Installation

> ⚠️ **Before installing, make sure `gemini.google.com` and the chat on it are accessible.** If not — find a VPN/proxy.

### Windows / macOS

```bash
pip install -r requirements.txt
playwright install chromium
python start.py
```

First launch:
1. Chromium opens → log in to Google.
2. Wait for Gemini to load.
3. Press **ENTER** in the console.
4. Session is saved, server starts on port `1717`.

If session was already saved, `--refresh` will try to silently update cookies in headless mode first.

### Linux Desktop

Google may block Playwright as an unsafe browser, so Linux uses **manual cookie flow**:

```bash
git clone https://github.com/l4ckofsleep/geminiweb2api
cd geminiweb2api
pip install -r requirements.txt
python start.py
```

On first launch, the script will ask for two cookies:
- `__Secure-1PSID`
- `SAPISID`

**How to get them:**
1. Open a regular browser, go to `gemini.google.com`.
2. Install the **Cookie-Editor** extension.
3. Copy the cookie values and paste them into the console when prompted.

> 💡 If a cookie is missing — send any message in Gemini and check again.

### Android (Termux)

```bash
pkg update && pkg upgrade
pkg install git python rust binutils
export ANDROID_API_LEVEL=24
pip install fastapi uvicorn httpx "httpx[socks]"

cd
git clone https://github.com/l4ckofsleep/geminiweb2api
cd geminiweb2api
python start.py
```

First launch:
1. Install **Kiwi Browser** or **Firefox**.
2. Install the **Cookie-Editor** extension.
3. Go to `gemini.google.com` (enable **Desktop mode**).
4. Copy cookies as requested by the console.

---

## 🔗 Connection

### SillyTavern (text)

1. **API** → `Chat Completion`
2. **Source** → `Custom (OpenAI-compatible)`
3. **Base URL** → `http://127.0.0.1:1717/v1`
4. **API Key** → anything (e.g., `banana`)
5. **Model** → select from the list above

#### Web Search

To enable search, connect via **Google AI Studio**:
- **API:** `Chat Completion`
- **Source:** `Google AI Studio`
- **Proxy:** `http://127.0.0.1:1717`
- **Password:** anything
- In the first settings tab, enable **`Enable Web Search`**

### SillyImages (images)

1. Select source **Gemini-compatible (nano-banana)**.
2. **Base URL** → `http://127.0.0.1:1717`
3. **API Key** → anything
4. **Model** → `nano-banana-pro` (with subscription) or `nano-banana-2` (free)

---

## 🚩 Launch Flags

| Flag | Description | Example |
|------|-------------|---------|
| `--temp` | Temporary chat (not saved to Google history) | `python start.py --temp` |
| `--proxy <url>` | Proxy (http/socks4/socks5) | `python start.py --proxy socks5://127.0.0.1:1080` |
| `--port <number>` | Change port | `python start.py --port 8080` |
| `--debug` | Verbose logging + raw responses | `python start.py --debug` |
| `--mobile` | Force manual cookie flow | `python start.py --mobile` |
| `--refresh` | Soft session refresh | `python start.py --refresh` |
| `--reauth` | Hard reset (Factory Reset) | `python start.py --reauth` |

---

## 🛡️ Proxy

If Gemini is blocked in your region:

```bash
python start.py --proxy socks5://127.0.0.1:1080
```

> 🚨 **CRITICAL RULE: IP matching**
>
> The IP you used to log in to the browser **MUST MATCH** the IP used by the script.
> - ❌ **Wrong:** log in via Netherlands VPN, run script without proxy.
> - ✅ **Right:** set the same proxy in the browser, log in, then run the script with the same proxy.

### Where to get proxies

- **Free** (testing only): [proxyscrape.com](https://proxyscrape.com), [free-proxy-list.net](https://free-proxy-list.net)
- **Paid** (for production): Proxy6, ProxyLine, Smartproxy, Oxylabs

### Browser setup

- **PC:** FoxyProxy / ZeroOmega extension.
- **Android:** Firefox + FoxyProxy, or VPN with split tunneling.

---

## 🔄 Troubleshooting

| Symptom | Solution |
|---------|----------|
| Empty response / default thinking block | Check [age-verification](https://myaccount.google.com/age-verification) and thinking settings. |
| Reference instead of image | Google censorship. Happens even in harmless scenes. |
| `502` before token retrieval | Issue on Google's side. Open Gemini in incognito — if `502` there too, just wait. |
| Session expired | `python start.py --refresh` (Win/Mac) or `--reauth` for full reset. |
| VPS not working | Google bans IPs of large hosting providers. Use home IP + proxy. |

Logs are in `logs/`:
- Daily logs by component (`api-YYYY-MM-DD.log`)
- Per-request logs
- Tokens and cookies are masked

---

## 📞 Contact

Found a bug or have ideas?

**Telegram:** [@roflenskoy](https://t.me/roflenskoy)

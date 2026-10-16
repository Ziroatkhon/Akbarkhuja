# Автоматизации (запланированные задачи Claude)

| Задача | Расписание (Asia/Tashkent) | Что делает | Промпт |
|---|---|---|---|
| **Утренний обзор дня** | каждый день, 07:20 | Читает Google Календарь и TickTick на сегодня, присылает текстовую сводку и аудиовыпуск «как утреннее радио» (голос Piper `ru-irinia-medium`) | [morning-radio/prompt.md](morning-radio/prompt.md) |
| **Утренняя сводка пар** | пн–сб, 06:52 | Пары по Odam anatomiyasi на сегодня; по субботам — напоминание про обновление расписания | [class-summary/prompt.md](class-summary/prompt.md) |

## Cron-выражения

```
Утренний обзор дня:   CRON_TZ=Asia/Tashkent 20 7 * * *
Утренняя сводка пар:  CRON_TZ=Asia/Tashkent 52 6 * * 1-6
```

Подключения: Google Calendar, TickTick. Уведомления: push.
Обе задачи только читают календарь и TickTick и ничего в них не меняют.

## Голос утреннего выпуска

`morning-radio/radio.sh` — озвучка текста в mp3:

- движок: [Piper](https://github.com/rhasspy/piper), голос `ru-irinia-medium` (v0.0.2 release на GitHub);
- настройки: `--length-scale 1.12 --sentence-silence 0.35 --noise-scale 0.5 --noise-w 0.6`;
- ударения ставятся в тексте символом U+0301 после ударной гласной (Акбарху́жа, Елизаве́та, аккредита́ция, О́дам анато́мияси).

## Как восстановить

Создать запланированную задачу в Claude с указанным расписанием и вставить текст из соответствующего `prompt.md`.

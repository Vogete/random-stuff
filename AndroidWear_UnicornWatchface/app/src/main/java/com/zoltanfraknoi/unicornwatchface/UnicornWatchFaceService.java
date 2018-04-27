package com.zoltanfraknoi.unicornwatchface;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Rect;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.Drawable;
import android.icu.util.Calendar;
import android.icu.util.TimeZone;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.os.SystemClock;
import android.support.wearable.watchface.CanvasWatchFaceService;
import android.support.wearable.watchface.WatchFaceStyle;
import android.view.SurfaceHolder;

/**
 * Created by Zoli on 2018-01-25.
 */

public class UnicornWatchFaceService extends CanvasWatchFaceService
{
    @Override
    public Engine onCreateEngine() {
        /* provide your watch face implementation */
        return new Engine();
    }

    private class Engine extends CanvasWatchFaceService.Engine {

        /* implement service callback methods */
        static final long INTERACTIVE_UPDATE_RATE_MS = 1000;
        static final int MSG_UPDATE_TIME = 0;

        Calendar mCalendar;

        // device features
        boolean mLowBitAmbient;
        boolean mBurnInProtection;

        // graphic objects
        Bitmap mBackgroundBitmap;

        // handler to update the time once a second in interactive mode
        final Handler mUpdateTimeHandler = new Handler() {
            @Override
            public void handleMessage(Message message) {
                switch (message.what) {
                    case MSG_UPDATE_TIME:
                        invalidate();
                        if (shouldTimerBeRunning()) {
                            long timeMs = System.currentTimeMillis();
                            long delayMs = INTERACTIVE_UPDATE_RATE_MS
                                    - (timeMs % INTERACTIVE_UPDATE_RATE_MS);
                            mUpdateTimeHandler
                                    .sendEmptyMessageDelayed(MSG_UPDATE_TIME, delayMs);
                        }
                        break;
                }
            }
        };

        // receiver to update the time zone
        final BroadcastReceiver mTimeZoneReceiver = new BroadcastReceiver() {
            @Override
            public void onReceive(Context context, Intent intent) {
                mCalendar.setTimeZone(TimeZone.getDefault());
                invalidate();
            }
        };

        @Override
        public void onCreate(SurfaceHolder holder) {
            super.onCreate(holder);
            /* initialize your watch face */

            // configure the system UI
            setWatchFaceStyle(new WatchFaceStyle.Builder(UnicornWatchFaceService.this)
                    .setBackgroundVisibility(WatchFaceStyle
                            .BACKGROUND_VISIBILITY_INTERRUPTIVE)
                    .setShowSystemUiTime(false)
                    .build());

            // load the background image
            Resources resources = UnicornWatchFaceService.this.getResources();
            Drawable backgroundDrawable = resources.getDrawable(R.drawable.unicorn_background, null);
            mBackgroundBitmap = ((BitmapDrawable) backgroundDrawable).getBitmap();

            // allocate a Calendar to calculate local time using the UTC time and time zone
            mCalendar = Calendar.getInstance();
        }

        @Override
        public void onPropertiesChanged(Bundle properties) {
            super.onPropertiesChanged(properties);
            /* get device features (burn-in, low-bit ambient) */

            mLowBitAmbient = properties.getBoolean(PROPERTY_LOW_BIT_AMBIENT, false);
            mBurnInProtection = properties.getBoolean(PROPERTY_BURN_IN_PROTECTION,
                    false);
        }

        @Override
        public void onTimeTick() {
            super.onTimeTick();
            /* the time changed */
            invalidate();
        }

        @Override
        public void onAmbientModeChanged(boolean inAmbientMode) {
            super.onAmbientModeChanged(inAmbientMode);
            /* the wearable switched between modes */

            if (mLowBitAmbient) {
                boolean antiAlias = !inAmbientMode;
            }

            invalidate();
            updateTimer();
        }

        @Override
        public void onDraw(Canvas canvas, Rect bounds) {
            /* draw your watch face */

            long frameStartTimeMs = SystemClock.elapsedRealtime();

            // Drawing code here

            if (shouldTimerBeRunning()) {
                long delayMs = SystemClock.elapsedRealtime() - frameStartTimeMs;
                if (delayMs > INTERACTIVE_UPDATE_RATE_MS) {
                    // This scenario occurs when drawing all of the components takes longer than an actual
                    // frame. It may be helpful to log how many times this happens, so you can
                    // fix it when it occurs.
                    // In general, you don't want to redraw immediately, but on the next
                    // appropriate frame (else block below).
                    delayMs = 0;
                } else {
                    // Sets the delay as close as possible to the intended framerate.
                    // Note that the recommended interactive update rate is 1 frame per second.
                    // However, if you want to include the sweeping hand gesture, set the
                    // interactive update rate up to 30 frames per second.
                    delayMs = INTERACTIVE_UPDATE_RATE_MS - delayMs;
                }
                updateTimeHandler.sendEmptyMessageDelayed(MSG_CODE_UPDATE_TIME, delayMs);
            }
        }

        @Override
        public void onVisibilityChanged(boolean visible) {
            super.onVisibilityChanged(visible);
            /* the watch face became visible or invisible */

            if (visible) {
                registerReceiver();

                // Update time zone in case it changed while we weren't visible.
                mCalendar.setTimeZone(TimeZone.getDefault());
            } else {
                unregisterReceiver();
            }

            // Whether the timer should be running depends on whether we're visible and
            // whether we're in ambient mode, so we may need to start or stop the timer
            updateTimer();

        }

        @Override
        public void onSurfaceChanged(
                SurfaceHolder holder, int format, int width, int height) {
            if (mBackgroundScaledBitmap == null
                    || mBackgroundScaledBitmap.getWidth() != width
                    || mBackgroundScaledBitmap.getHeight() != height) {
                mBackgroundScaledBitmap = Bitmap.createScaledBitmap(mBackgroundBitmap,
                        width, height, true /* filter */);
            }
            super.onSurfaceChanged(holder, format, width, height);
        }

        private void updateTimer() {
            mUpdateTimeHandler.removeMessages(MSG_UPDATE_TIME);
            if (shouldTimerBeRunning()) {
                mUpdateTimeHandler.sendEmptyMessage(MSG_UPDATE_TIME);
            }
        }

        private boolean shouldTimerBeRunning() {
            return isVisible() && !isInAmbientMode();
        }

        private void registerReceiver() {
            if (mRegisteredTimeZoneReceiver) {
                return;
            }
            mRegisteredTimeZoneReceiver = true;
            IntentFilter filter = new IntentFilter(Intent.ACTION_TIMEZONE_CHANGED);
            UnicornWatchFaceService.this.registerReceiver(mTimeZoneReceiver, filter);
        }

        private void unregisterReceiver() {
            if (!mRegisteredTimeZoneReceiver) {
                return;
            }
            mRegisteredTimeZoneReceiver = false;
            UnicornWatchFaceService.this.unregisterReceiver(mTimeZoneReceiver);
        }


    }

}

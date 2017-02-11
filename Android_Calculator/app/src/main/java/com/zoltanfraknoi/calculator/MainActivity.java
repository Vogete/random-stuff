package com.zoltanfraknoi.calculator;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity
{

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

    }

    public void btnOnClick(View v){

        TextView lblResult = (TextView) findViewById(R.id.lblResult);
        Button btnPlus = (Button) findViewById(R.id.btnMinus);

        int alma = v.getId();
        lblResult.setText(Integer.toString(alma));

    }
}

Shader "UI/PieChart"
{
    Properties
    {
        [PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_Color ("Color", Color) = (0.3, 0.3, 0.3, 0.3)
		_Fraction ("Fraction", float) = 1
		[HideInInspector]_Pi ("Pi", float) = 3.14
    }

    SubShader
    {
        Tags
        {
            "Queue"="Transparent"
            "IgnoreProjector"="True"
            "RenderType"="Transparent"
            "PreviewType"="Plane"
            "CanUseSpriteAtlas"="True"
        }

        Cull Off
        Lighting Off
		ZWrite Off
        ZTest [unity_GUIZTestMode]
        Blend SrcAlpha One

        Pass
        {

        CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 2.0

            #include "UnityCG.cginc"
            #include "UnityUI.cginc"

            struct appdata_t
            {
                float4 vertex   : POSITION;
                float2 texcoord : TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex   : SV_POSITION;
                float2 texcoord  : TEXCOORD0;
				float2 dist : TEXCOORD1;
            };

            fixed4 _TextureSampleAdd;

            v2f vert(appdata_t v)
            {
                v2f OUT;
                OUT.vertex = UnityObjectToClipPos(v.vertex);
                OUT.texcoord = v.texcoord;
				OUT.dist = v.texcoord * 2 - float2(1, 1);
                return OUT;
            }

            sampler2D _MainTex;
			float _Fraction;
			float _Pi;
			fixed4 _Color;

            fixed4 frag(v2f IN) : SV_Target
            {
				float mag = sqrt(pow(IN.dist.x, 2) + pow(IN.dist.y, 2));
				float csqr = pow(IN.dist.x, 2) + pow(1 - IN.dist.y, 2);
				float angle = acos((1 + pow(mag, 2) - csqr) / (2 * mag)) / _Pi;

				if (IN.dist.x < 0)
				{
					if (_Fraction < 0.5)
					{
						discard;
					}
					else
					{
						angle = 2 - angle;
					}
				}
				if (_Fraction < angle / 2)
				{
					discard;
				}

				return (tex2D(_MainTex, IN.texcoord) * _Color);
            }
        ENDCG
        }
    }
}

/*
 * By Jason Hein
 */


using UnityEngine;

/// <summary>
/// Causes a UI pie chart using a pie chart shader to fill out clockwise over a set time.
/// </summary>
[RequireComponent(typeof(SpriteRenderer))]
public class PieChartTimer : MonoBehaviour {

    // Timer
    [SerializeField] float m_TimeToComplete = 1f;
    float m_Timer = 0f;

    // Pie chart
    Material m_PieChart;
    const string PIE_FRACTION = "_Fraction";

    // Get the pie chart
    private void Awake()
    {
        SpriteRenderer rend = GetComponent<SpriteRenderer>();
        if (rend.material)
        {
            m_PieChart = rend.material;
            m_PieChart.SetFloat(PIE_FRACTION, 0f);
        }
#if UNITY_EDITOR
        else
        {
            Debug.LogError("The sprite renderer attached to the PieChart script must have a material.");
        }
#endif
    }

    // When enabled, check if the timer is insantly done.
    private void OnEnable()
    {
        if (m_TimeToComplete <= 0f)
        {
            SetComplete();
        }
    }

    // Fill out the pie chart each frame
    void LateUpdate ()
    {
        m_Timer += Time.deltaTime;
        if (m_Timer >= m_TimeToComplete)
        {
            SetComplete();
        }
        else
        {
            m_PieChart.SetFloat(PIE_FRACTION, m_Timer / m_TimeToComplete);
        }
    }

    /// <summary>
    /// Resets the pie chart timer.
    /// </summary>
    public void Restart ()
    {
        m_Timer = 0f;
        m_PieChart.SetFloat(PIE_FRACTION, 0f);
    }

    /// <summary>
    /// Instantly finishes the pie chart and sets it to completely filled out.
    /// </summary>
    public void SetComplete ()
    {
        m_Timer = m_TimeToComplete;
        m_PieChart.SetFloat(PIE_FRACTION, 1f);
        enabled = false;
    }
}
